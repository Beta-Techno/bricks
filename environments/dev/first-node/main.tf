terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

# Configure the Proxmox provider at the root level
provider "proxmox" {
  pm_api_url      = "https://${var.ip_address}:8006/api2/json"
  pm_user         = "root@pam"
  pm_password     = var.root_password
  pm_tls_insecure = true
}

# Configure the Proxmox host
module "proxmox_host" {
  source = "../../../modules/proxmox-host"

  ip_address         = var.ip_address
  root_password      = var.root_password
  automation_password = var.automation_password
  network_ports      = var.network_ports
  ssh_port          = var.ssh_port
}

# Output the API URL and automation user details for use in VM creation
output "api_url" {
  value = module.proxmox_host.api_url
  description = "The API URL for the Proxmox host"
}

output "automation_user" {
  value = module.proxmox_host.automation_user
  description = "The automation user details for API access"
  sensitive = true
} 