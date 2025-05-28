locals {
  disk_bus = trimspace(var.disk.type) != "" ? var.disk.type : "scsi"
  disk_if  = "${local.disk_bus}0"
}

# Create the VM
resource "proxmox_virtual_environment_vm" "vm" {
  node_name = var.node_name
  vm_id     = var.vm_id
  name      = var.name
  tags      = var.tags
  template  = var.template

  # Set boot order: first CD-ROM, then disk
  boot_order = ["ide2", local.disk_if]

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

  # Disk configuration - API-only path
  disk {
    datastore_id = var.disk.storage
    size         = var.disk.size
    interface    = local.disk_if
    ssd          = var.disk.ssd
    discard      = "on"
  }

  # CD-ROM configuration
  cdrom {
    file_id = "local:iso/${var.iso.file}"
    enabled = true
    interface = "ide2"
  }

  # Network configuration
  network_device {
    bridge = var.network.bridge
    model  = var.network.model
    vlan_id = var.network.tag
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
    }
  }

  # Lifecycle configuration
  lifecycle {
    ignore_changes = [
      network_device,
      initialization
    ]
  }
} 