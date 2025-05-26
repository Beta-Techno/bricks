terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

provider "proxmox" {
  pm_api_url          = var.api_url
  pm_user             = var.automation_user.userid
  pm_api_token_id     = var.automation_user.token_id
  pm_api_token_secret = var.automation_user.token_secret
  pm_tls_insecure     = true
} 