# Create VMs
resource "proxmox_virtual_environment_vm" "vms" {
  for_each = var.vms

  name        = each.key
  node_name   = var.target_node
  vm_id       = each.value.vmid
  clone_id    = each.value.template
  full_clone  = true

  cores   = each.value.cores
  sockets = each.value.sockets
  memory  = each.value.memory

  network_device {
    bridge = var.network_bridge
    model  = each.value.network_model != null ? each.value.network_model : "virtio"
  }

  disk {
    datastore_id = var.storage_pool
    size         = each.value.disk
  }

  operating_system {
    type = "cloud-init"
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = var.network_gateway
      }
    }
    user_data = jsonencode({
      users = [{
        name = each.value.ciuser
        passwd = each.value.cipassword
        ssh_authorized_keys = [each.value.sshkeys]
      }]
    })
  }

  # Lifecycle rules
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      network_device,
      disk,
    ]
  }

  tags = each.value.tags
}

# Create containers
resource "proxmox_virtual_environment_container" "containers" {
  for_each = var.containers

  node_name  = var.target_node
  vm_id      = each.value.vmid
  hostname   = each.key
  template_id = each.value.template
  memory     = each.value.memory
  cores      = each.value.cores
  swap       = each.value.swap
  
  rootfs {
    datastore_id = var.storage_pool
    size         = each.value.disk
  }

  network_device {
    name   = each.value.network_name != null ? each.value.network_name : "eth0"
    bridge = var.network_bridge
  }

  initialization {
    ip_config {
      ipv4 {
        address = "${each.value.ip}/24"
        gateway = var.network_gateway
      }
    }
  }

  # Lifecycle rules
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      network_device,
      rootfs,
    ]
  }

  tags = each.value.tags
} 