output "automation_token" {
  value     = module.proxmox_foundation.automation_user.token
  sensitive = true  # Mark as sensitive
}

output "api_url" {
  description = "The Proxmox API endpoint URL"
  value       = "https://${var.ip_address}:8006/api2/json"
}

output "hostname" {
  description = "The hostname of the Proxmox node"
  value       = var.hostname
} 