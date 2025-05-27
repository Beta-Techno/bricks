provider "proxmox" {
  endpoint = var.api_endpoint
  insecure = true
  username = "root@pam"
  password = var.root_password
}

# Configure the Proxmox host
module "proxmox_host" {
  source = "../../../modules/proxmox-host"

  api_endpoint      = var.api_endpoint
  ip_address        = var.ip_address
  root_password     = var.root_password
  hostname          = var.hostname
  network_ports     = var.network_ports
  ssh_port          = var.ssh_port
}

module "proxmox_network" {
  source = "../../../modules/proxmox-network"
  
  node_name = var.hostname
  
  bridges = {
    "vmbr0" = {
      vlan_aware = true
      ports      = var.network_ports
      comment    = "Main bridge for VM networking"
    }
  }
  depends_on = [module.proxmox_host]
}

# Output the API URL and automation user details for use in VM creation
output "api_url" {
  value       = module.proxmox_host.api_url
  description = "The API URL for the Proxmox host"
}

output "automation_user" {
  value       = module.proxmox_host.automation_user
  description = "The automation user details for API access"
  sensitive   = true
}

# Output network details
output "bridges" {
  value       = module.proxmox_network.bridges
  description = "The configured network bridges"
} 