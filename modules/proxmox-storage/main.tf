resource "proxmox_virtual_environment_storage" "pools" {
  for_each = var.pools

  node_name = var.node_name
  name      = each.key
  type      = each.value.type
  path      = each.value.path
  content   = each.value.content

  enabled = each.value.enabled
  comment = each.value.comment
}

resource "proxmox_virtual_environment_storage_volume" "volumes" {
  for_each = var.volumes

  node_name = var.node_name
  storage   = each.value.storage
  name      = each.key
  size      = each.value.size
  format    = each.value.format

  comment = each.value.comment
} 