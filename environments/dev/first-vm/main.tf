# Check if template exists
data "proxmox_virtual_environment_vm" "template" {
  node_name = var.target_node
  vm_id     = var.template_name
}

# Create a VM
resource "proxmox_virtual_environment_vm" "test_vm" {
  name        = var.vm_name
  node_name   = var.target_node
  vm_id       = var.vm_id
  clone       = data.proxmox_virtual_environment_vm.template.name
  full_clone  = true

  cores   = var.vm_cores
  sockets = var.vm_sockets
  memory  = var.vm_memory

  network_device {
    bridge = var.network_bridge
    model  = "virtio"
  }

  disk {
    datastore_id = var.storage_pool
    size         = var.vm_disk_size
  }

  operating_system {
    type = "cloud-init"
  }

  initialization {
    ip_config {
      ipv4 {
        address = var.ip_config
      }
    }
  }
} 