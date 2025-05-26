terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

# Use the proxmox provider module
module "proxmox_provider" {
  source = "../../proxmox-provider"

  pm_api_url          = var.pm_api_url
  pm_user             = var.pm_user
  pm_api_token_id     = var.pm_api_token_id
  pm_api_token_secret = var.pm_api_token_secret
}

# Create a VM
resource "proxmox_vm_qemu" "test_vm" {
  name        = "test-vm"
  target_node = "pve"  # Change this to your node name
  vmid        = 100    # Change this to your desired VMID
  clone       = "ubuntu-22.04-template"  # Change this to your template name
  full_clone  = true

  cores   = 2
  sockets = 1
  memory  = 2048

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    type    = "scsi"
    storage = "local-lvm"
    size    = "10G"
  }

  os_type = "cloud-init"
  ipconfig0 = "ip=dhcp"
} 