output "bridges" {
  description = "Map of created Linux bridges"
  value       = proxmox_virtual_environment_network_linux_bridge.bridges
}
 
output "vlans" {
  description = "Map of created VLANs"
  value       = proxmox_virtual_environment_network_linux_vlan.vlans
} 