output "automation_user" {
  description = "The automation user details for API access"
  value       = module.first_node.automation_user
  sensitive   = true
}

output "api_url" {
  description = "The API URL for the Proxmox host"
  value       = module.first_node.api_url
}

output "bridges" {
  description = "The configured network bridges"
  value       = module.first_node.bridges
} 