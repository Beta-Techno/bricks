terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

# Configure the Proxmox provider at the root level using automation user
provider "proxmox" {
  pm_api_url          = var.api_url
  pm_user             = var.automation_user.userid
  pm_api_token_id     = var.automation_user.token_id
  pm_api_token_secret = var.automation_user.token_secret
  pm_tls_insecure     = true
}

# Check if template exists
data "proxmox_virtual_machine" "template" {
  vmid = var.template_name
  node = var.target_node
}

# Create a VM
resource "proxmox_vm_qemu" "test_vm" {
  name        = var.vm_name
  target_node = var.target_node
  vmid        = var.vm_id
  clone       = data.proxmox_virtual_machine.template.name
  full_clone  = true

  cores   = var.vm_cores
  sockets = var.vm_sockets
  memory  = var.vm_memory

  network {
    bridge = var.network_bridge
    model  = "virtio"
  }

  disk {
    type    = "scsi"
    storage = var.storage_pool
    size    = var.vm_disk_size
  }

  os_type = "cloud-init"
  ipconfig0 = var.ip_config
} 