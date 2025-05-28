terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.78.0, < 0.79.0"
    }
  }
}

provider "proxmox" {
  endpoint = var.api_endpoint
  # Use API token if available, otherwise use root credentials
  api_token = var.api_token != "" ? var.api_token : null
  username = var.api_token == "" ? "root@pam" : null
  password = var.api_token == "" ? var.root_password : null
  insecure = true  # Allow insecure connections for initial setup
} 