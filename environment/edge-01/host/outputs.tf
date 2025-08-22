output "automation_token" {
  value     = module.proxmox_foundation.automation_user.token
  sensitive = true  # Mark as sensitive
}

output "hostname" {
  description = "The hostname of the Proxmox node"
  value       = var.hostname
} 