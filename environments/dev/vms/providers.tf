terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.46.0"
    }
  }
  required_version = ">= 1.0.0"
}

provider "proxmox" {
  endpoint = var.api_endpoint
  api_token = var.automation_token
  insecure = true
} 