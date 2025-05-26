terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://${var.ip_address}:8006/api2/json"
  pm_user         = "root@pam"
  pm_password     = var.root_password
  pm_tls_insecure = true
} 