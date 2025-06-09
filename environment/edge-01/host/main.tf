provider "proxmox" {
  endpoint = var.api_endpoint
  username = var.username
  password = var.password
  insecure = true
}

# Configure the Proxmox host
module "proxmox_host" {
  source = "../../../modules/proxmox/host"

  api_endpoint      = var.api_endpoint
  ip_address        = var.ip_address
  root_password     = var.root_password
  hostname          = var.hostname
  network_ports     = var.network_ports
  ssh_port          = var.ssh_port
  root_ssh_public_key = var.root_ssh_public_key
}

module "proxmox_network" {
  source = "../../../modules/proxmox/network"
  
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

# Configure Proxmox roles and ACLs
module "proxmox_foundation" {
  source = "../../../modules/proxmox/foundation"
  
  api_token = var.api_token
  
  depends_on = [module.proxmox_host, module.proxmox_network]
}

# Manage ISO images
module "proxmox_iso" {
  source = "../../../modules/proxmox/iso"
  
  node_name    = var.hostname
  storage_pool = "local"

  isos = {
    "ubuntu-22.04.5-server" = {
      source_url = "https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso"
      filename   = "ubuntu-22.04.5-live-server-amd64.iso"
      overwrite  = true
    }
  }

  depends_on = [module.proxmox_host, module.proxmox_foundation]
}

# Output the API URL and automation user details for use in VM creation
output "api_url" {
  value       = module.proxmox_host.api_url
  description = "The API URL for the Proxmox host"
}

output "automation_user" {
  value       = module.proxmox_foundation.automation_user
  description = "The automation user details for API access"
  sensitive   = true
}

# Output network details
output "bridges" {
  value       = module.proxmox_network.bridges
  description = "The configured network bridges"
}

# Output ISO details
output "isos" {
  value       = module.proxmox_iso.isos
  description = "The managed ISO images"
} 