resource "proxmox_virtual_environment_network_linux_bridge" "bridges" {
  for_each = var.bridges

  node_name = var.node_name
  name      = each.key

  vlan_aware = each.value.vlan_aware
  ports      = each.value.ports

  comment = each.value.comment
}

resource "proxmox_virtual_environment_network_linux_vlan" "vlans" {
  for_each = var.vlans

  node_name = var.node_name
  name      = each.key
  vlan      = each.value.vlan_id
  interface = each.value.interface

  comment = each.value.comment
} 