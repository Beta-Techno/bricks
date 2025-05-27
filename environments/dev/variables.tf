variable "api_endpoint" {
  description = "The API endpoint for the Proxmox host"
  type        = string
}
 
variable "api_token" {
  description = "The API token for authentication in the format userid!tokenid=secret"
  type        = string
  sensitive   = true
} 