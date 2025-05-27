provider "proxmox" {
  endpoint = var.api_endpoint
  api_token = var.api_token
  insecure = false
} 