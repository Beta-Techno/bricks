resource "proxmox_virtual_environment_network_linux_bridge" "bridges" {
  for_each = var.bridges

  node_name = var.node_name
  name      = each.key

  vlan_aware = each.value.vlan_aware
  ports      = each.value.ports

  comment = each.value.comment
  autostart = true

  lifecycle {
    ignore_changes = [
      address,
      gateway
    ]
  }
}

# resource "proxmox_virtual_environment_network_linux_vlan" "vlans" {
#   for_each = var.vlans
#   node_name = var.node_name
#   vlan_id   = each.value.vlan_id
#   base_interface = each.value.base_interface
#   comment   = each.value.comment
# } 