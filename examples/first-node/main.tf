terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

# Configure the Proxmox host
module "proxmox_host" {
  source = "../../proxmox-host"

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