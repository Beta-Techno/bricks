output "bridges" {
  description = "The configured network bridges"
  value = {
    for name, bridge in proxmox_virtual_environment_network_linux_bridge.bridges : name => {
      name       = bridge.name
      vlan_aware = bridge.vlan_aware
      ports      = bridge.ports
      comment    = bridge.comment
    }
  }
}
 
# output "vlans" {
#   description = "Map of created VLANs"
#   value = {
#     for name, vlan in proxmox_virtual_environment_network_linux_vlan.vlans : name => {
#       name      = vlan.name
#       vlan_id   = vlan.vlan_id
#       base_interface = vlan.base_interface
#       comment   = vlan.comment
#     }
#   }
# } 