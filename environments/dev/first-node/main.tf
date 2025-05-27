terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.78, < 0.79"
    }
  }
}

# Configure the Proxmox host
module "proxmox_host" {
  source = "../../../modules/proxmox-host"

  ip_address         = var.ip_address
  root_password      = var.root_password
  automation_password = var.automation_password
  network_ports      = var.network_ports
  ssh_port          = var.ssh_port
  ssh_public_key    = var.ssh_public_key
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
}

module "proxmox_storage" {
  source = "../../../modules/proxmox-storage"
  
  node_name = var.hostname
  
  pools = {
    "local-lvm" = {
      type    = "lvm"
      path    = "/dev/sda3"  # This should be the LVM volume group path. Adjust based on your disk layout.
      content = ["images", "rootdir", "iso"]
      comment = "Local LVM storage for VMs"
    }
  }
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

# Output network and storage details
output "bridges" {
  value       = module.proxmox_network.bridges
  description = "The configured network bridges"
}

output "storage_pools" {
  value       = module.proxmox_storage.pools
  description = "The configured storage pools"
} 