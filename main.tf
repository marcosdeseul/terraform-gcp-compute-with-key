terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.42.0"
    }
    ssh = {
      source  = "loafoe/ssh"
      version = "1.0.0"
    }
  }
}

# https://stackoverflow.com/questions/49743220/how-do-i-create-a-ssh-key-in-terraform-aws
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "pem_file" {
  content         = tls_private_key.this.private_key_pem
  filename        = "${var.pem_location}/${var.key_name}/${var.key_name}.pem"
  file_permission = "0600"
}

resource "local_file" "access_shell_script" {
  content         = "ssh -i ./${var.key_name}.pem ${var.os}@${google_compute_instance.this.network_interface.0.access_config.0.nat_ip}"
  filename        = "${var.pem_location}/${var.key_name}/${var.key_name}.sh"
  file_permission = "0500"
}

data "google_compute_image" "ubuntu_image" {
  family  = "ubuntu-2204-lts"
  project = "ubuntu-os-cloud"
}

data "google_compute_image" "centos_image" {
  family  = "centos-7"
  project = "centos-cloud"
}

resource "google_compute_instance" "this" {
  name         = "marco-${var.key_name}"
  machine_type = var.instance_type
  zone         = var.zone
  tags         = var.compute_tags

  boot_disk {
    initialize_params {
      image = var.os_image == "" ? local.os_map[var.os] : var.os_image
      size  = var.volume_size
    }
  }

  // Local SSD disk
  # scratch_disk {
  #   interface = "SCSI"
  # }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
      // nat_ip = google_compute_address.static.address
    }
  }

  metadata = {
    ssh-keys = "${var.os}:${tls_private_key.this.public_key_openssh}"
  }

  # metadata_startup_script = "echo hi > /test.txt"

  # service_account {
  #   # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
  #   email  = "marco-terraform@h2o-gce.iam.gserviceaccount.com"
  #   scopes = ["cloud-platform"]
  # }
}
