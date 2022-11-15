locals {
  os_map = {
    ubuntu : data.google_compute_image.ubuntu_image.self_link
    centos : data.google_compute_image.centos_image.self_link
  }
  public_ip = google_compute_instance.this.network_interface.0.access_config.0.nat_ip
}
