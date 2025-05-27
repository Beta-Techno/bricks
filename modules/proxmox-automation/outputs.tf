output "user_id" {
  description = "The ID of the created automation user"
  value       = proxmox_virtual_environment_user.automation.user_id
}

output "token_id" {
  description = "The ID of the created API token"
  value       = proxmox_virtual_environment_api_token.automation.token_id
}

output "token_secret" {
  description = "The secret of the created API token (only available on initial creation)"
  value       = proxmox_virtual_environment_api_token.automation.secret
  sensitive   = true
}

output "full_token" {
  description = "The full API token in the format userid!tokenid=secret"
  value       = "${proxmox_virtual_environment_user.automation.user_id}!${proxmox_virtual_environment_api_token.automation.token_id}=${proxmox_virtual_environment_api_token.automation.secret}"
  sensitive   = true
} 