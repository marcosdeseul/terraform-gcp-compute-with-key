variable "key_name" {
  description = "Value of key pair"
  type        = string
}

variable "pem_location" {
  description = "Location for Pem Key File"
  type        = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "n2-standard-16"
}

variable "volume_size" {
  description = "EC2 Instance Type"
  type        = number
  default     = 1023
}

variable "os" {
  description = "Specific Operating System"
  type        = string
  default     = "ubuntu"
}

variable "os_image" {
  description = "Specific Operating System Image"
  type        = string
  default     = ""
}

variable "region" {
  description = "Specific region for Compute"
  type        = string
  default     = "asia-southeast1"
}

variable "zone" {
  description = "Specific Zone for Compute"
  type        = string
  default     = "asia-southeast1-a"
}

variable "compute_tags" {
  description = "Tags for compute instances"
  type        = list
  default     = ["dai"]
}

variable "license_sig_location" {
  description = "location of license.sig in the terraform folder"
  type        = string
  default     = "templates/license.sig"
}
