output "automation_token" {
  value     = module.proxmox_host.automation_token
  sensitive = true  # Mark as sensitive
} 