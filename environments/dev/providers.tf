provider "proxmox" {
  endpoint = var.api_endpoint
  # Use API token if available, otherwise use root credentials
  api_token = var.api_token != "" ? var.api_token : null
  username = var.api_token == "" ? "root@pam" : null
  password = var.api_token == "" ? var.root_password : null
  insecure = false
} 