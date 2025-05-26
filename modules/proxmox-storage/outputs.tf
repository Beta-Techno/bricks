output "pools" {
  description = "Map of created storage pools"
  value       = proxmox_virtual_environment_storage.pools
}
 
output "volumes" {
  description = "Map of created storage volumes"
  value       = proxmox_virtual_environment_storage_volume.volumes
} 