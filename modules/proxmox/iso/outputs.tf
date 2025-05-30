output "isos" {
  description = "Map of managed ISOs with their details"
  value = {
    for k, v in proxmox_virtual_environment_file.isos : k => {
      file_name = v.file_name
      file_modification_date = v.file_modification_date
    }
  }
}

output "storage" {
  description = "Storage details for ISO management"
  value = {
    pool = var.storage_pool
    node = var.node_name
  }
} 