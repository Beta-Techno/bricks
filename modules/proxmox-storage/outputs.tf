output "pools" {
  description = "Map of created storage pools"
  value = {
    for name, pool in proxmox_virtual_environment_storage.pools : name => {
      id   = pool.id
      type = pool.type
    }
  }
}
 
output "volumes" {
  description = "Map of created storage volumes"
  value = {
    for name, volume in proxmox_virtual_environment_storage_volume.volumes : name => {
      id   = volume.id
      size = volume.size
    }
  }
} 