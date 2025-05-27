output "api_url" {
  description = "The API URL for the Proxmox host"
  value       = "https://${var.ip_address}:8006/api2/json"
}

output "automation_user" {
  description = "The automation user details"
  value = {
    userid        = proxmox_virtual_environment_user.automation.user_id
    token_id      = proxmox_virtual_environment_api_token.automation.token_id
    token_secret  = proxmox_virtual_environment_api_token.automation.secret
  }
  sensitive = true
}

output "storage" {
  description = "The configured storage details"
  value = {
    local_lvm = "local-lvm"
  }
}

output "network" {
  description = "The configured network details"
  value = {
    bridge = "vmbr0"
    ports  = var.network_ports
  }
} 