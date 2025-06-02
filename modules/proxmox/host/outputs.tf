output "api_url" {
  description = "The API URL for the Proxmox host"
  value       = var.api_endpoint
}

output "automation_user" {
  description = "Automation user + token"
  value = {
    userid      = proxmox_virtual_environment_user.automation.user_id
    token_name  = length(proxmox_virtual_environment_user_token.automation) > 0 ? proxmox_virtual_environment_user_token.automation[0].token_name : null
    full_token  = length(proxmox_virtual_environment_user_token.automation) > 0 ? proxmox_virtual_environment_user_token.automation[0].value : null
  }
  sensitive = true
}

output "automation_token" {
  value     = local.effective_token
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