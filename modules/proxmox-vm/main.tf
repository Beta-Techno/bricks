# Create the VM
resource "proxmox_virtual_environment_vm" "vm" {
  node_name = var.node_name
  vm_id     = var.vm_id
  name      = var.name
  tags      = var.tags
  template  = var.template

  # CPU configuration
  cpu {
    cores   = var.cpu.cores
    sockets = var.cpu.sockets
    type    = var.cpu.type
  }

  # Memory configuration
  memory {
    dedicated = var.memory
  }

  # Disk configuration
  disk {
    datastore_id = var.disk.storage
    file_id      = var.iso.file
    interface    = var.disk.type
    size         = var.disk.size
    ssd          = var.disk.ssd
    discard      = var.disk.discard
  }

  # Network configuration
  network_device {
    bridge = var.network.bridge
    model  = var.network.model
    vlan_id = var.network.tag
  }

  # Cloud-init configuration if provided
  dynamic "cloud_init" {
    for_each = var.cloud_init != null ? [1] : []
    content {
      user_data = var.cloud_init.user_data
      network_config = var.cloud_init.network_config
    }
  }

  # Operating system configuration
  operating_system {
    type = "l26"
  }

  # Initialization configuration
  initialization {
    ip_config {
      ipv4 {
        address = var.ip_config != null ? var.ip_config.ip : null
        gateway = var.ip_config != null ? var.ip_config.gateway : null
      }
      dns {
        servers = var.ip_config != null ? var.ip_config.dns : null
      }
    }

    user_data = var.cloud_init != null ? var.cloud_init.user_data : null
    ssh_keys  = var.ssh_keys
  }

  # Lifecycle configuration
  lifecycle {
    ignore_changes = [
      network_device,
      initialization
    ]
  }
} 