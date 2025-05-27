# Get node information
data "proxmox_virtual_environment_node" "node" {
  node_name = var.target_node
}

# Get storage information
data "proxmox_virtual_environment_storage" "storage" {
  node_name = var.target_node
  name      = var.storage_pool
}

# Get template information
data "proxmox_virtual_environment_vm" "templates" {
  for_each  = var.vms
  node_name = var.target_node
  vm_id     = each.value.template

  lifecycle {
    postcondition {
      condition     = self.status == "stopped"
      error_message = "Template ${each.value.template} must be in stopped state"
    }
  }
} 