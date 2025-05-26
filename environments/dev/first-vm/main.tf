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