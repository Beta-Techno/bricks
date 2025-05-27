resource "proxmox_virtual_environment_storage" "pools" {
  for_each = var.pools

  node_name = var.node_name
  name      = each.key
  type      = each.value.type
  device    = each.value.type == "lvm" || each.value.type == "lvmthin" ? each.value.path : null
  path      = each.value.type != "lvm" && each.value.type != "lvmthin" ? each.value.path : null
  content   = each.value.content

  enabled = each.value.enabled
  comment = each.value.comment

  lifecycle {
    precondition {
      condition     = contains(["lvm", "lvmthin", "nfs", "cifs", "dir", "rbd", "zfs"], each.value.type)
      error_message = "Storage type must be one of: lvm, lvmthin, nfs, cifs, dir, rbd, zfs"
    }
    precondition {
      condition     = alltrue([for c in each.value.content : contains(["images", "rootdir", "iso", "vztmpl", "snippets", "backup"], c)])
      error_message = "Content types must be one or more of: images, rootdir, iso, vztmpl, snippets, backup"
    }
  }
}

resource "proxmox_virtual_environment_storage_volume" "volumes" {
  for_each = var.volumes

  node_name    = var.node_name
  datastore_id = each.value.datastore_id
  name         = each.key
  size         = each.value.size
  format       = each.value.format

  comment = each.value.comment

  lifecycle {
    precondition {
      condition     = contains(["raw", "qcow2", "vmdk"], each.value.format)
      error_message = "Volume format must be one of: raw, qcow2, vmdk"
    }
    precondition {
      condition     = contains(keys(var.pools), each.value.datastore_id)
      error_message = "The datastore_id must reference an existing storage pool"
    }
  }
} 