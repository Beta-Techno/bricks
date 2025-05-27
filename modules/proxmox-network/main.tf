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
  vlan_id   = each.value.vlan_id
  base_interface = each.value.interface
  comment   = each.value.comment

  lifecycle {
    precondition {
      condition     = each.value.vlan_id >= 1 && each.value.vlan_id <= 4094
      error_message = "VLAN ID must be between 1 and 4094"
    }
  }
} 