terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

# Provider configuration using automation user
provider "proxmox" {
  pm_api_url          = var.api_url
  pm_user             = var.automation_user.userid
  pm_api_token_id     = var.automation_user.token_id
  pm_api_token_secret = var.automation_user.token_secret
  pm_tls_insecure     = true
}

# Create VMs
resource "proxmox_vm_qemu" "vms" {
  for_each = var.vms

  name        = each.key
  target_node = var.target_node
  vmid        = each.value.vmid
  clone       = each.value.template
  full_clone  = true

  cores   = each.value.cores
  sockets = each.value.sockets
  memory  = each.value.memory

  network {
    bridge = var.network_bridge
    model  = "virtio"
  }

  disk {
    type    = "scsi"
    storage = var.storage_pool
    size    = each.value.disk
  }

  # Cloud-init configuration
  os_type = "cloud-init"
  ipconfig0 = "ip=${each.value.ip}/24,gw=${var.network_gateway}"
  ciuser     = each.value.ciuser
  cipassword = each.value.cipassword
  sshkeys    = each.value.sshkeys

  # Lifecycle rules
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      network,
      disk,
    ]
  }

  tags = each.value.tags
}

# Create containers
resource "proxmox_lxc" "containers" {
  for_each = var.containers

  hostname     = each.key
  target_node  = var.target_node
  ostemplate   = each.value.template
  memory       = each.value.memory
  cores        = each.value.cores
  swap         = each.value.swap
  
  rootfs {
    storage = var.storage_pool
    size    = each.value.disk
  }

  network {
    name   = "eth0"
    bridge = var.network_bridge
    ip     = "${each.value.ip}/24"
    gw     = var.network_gateway
  }

  # Lifecycle rules
  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      network,
      rootfs,
    ]
  }

  tags = each.value.tags
} 