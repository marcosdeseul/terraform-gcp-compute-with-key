# terraform-gcp-compute-with-key

A Terraform module for GCP cloud compute to create a ssh key automatically

## How to use

This code below will create a cloud compute instance with a key file in `certs/gcp-compute/` folder

```terraform
module "compute-auto" {
  source       = "git@github.com:marcosdeseul/terraform-gcp-compute-with-key.git"
  key_name     = "gcp-compute"
  pem_location = "${path.module}/certs"
  # region       = var.gcp_region
  zone         = var.gcp_zone
  # os_image     = "https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-2204-jammy-v20221101a"
}

output "gcp-compute-auto-aus" {
  value       = module.compute-auto-aus.public_ip
  description = "GCP Compute Aus Public IP"
}
```
