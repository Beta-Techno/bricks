output "api_url" {
  description = "The API URL for the Proxmox host"
  value       = var.api_endpoint
}

output "automation_user" {
  description = "Automation user + token"
  value = {
    userid      = proxmox_virtual_environment_user.automation.user_id
    token_name  = proxmox_virtual_environment_user_token.automation.token_name
    full_token  = proxmox_virtual_environment_user_token.automation.value  # userid!token=value
  }
  sensitive = true
}

output "automation_token" {
  value     = proxmox_virtual_environment_user_token.automation.value
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