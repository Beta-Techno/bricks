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
  username = "root@pam"
  password = var.root_password
  insecure = true  # Allow insecure connections for initial setup
} 