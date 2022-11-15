output "public_ip" {
  value       = google_compute_instance.this.network_interface.0.access_config.0.nat_ip
  description = "Public EC2 IP"
}

output "private_key" {
  value = tls_private_key.this
}
