# Get node information
data "proxmox_node" "node" {
  node = var.target_node
}

# Get storage information
data "proxmox_storage" "storage" {
  storage = var.storage_pool
  node    = var.target_node
}

# Get template information
data "proxmox_virtual_machine" "templates" {
  for_each = var.vms
  vmid     = each.value.template
  node     = var.target_node
} 