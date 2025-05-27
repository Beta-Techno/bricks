variable "node_name" {
  description = "The name of the Proxmox node"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$", var.node_name))
    error_message = "The node_name must be alphanumeric with optional hyphens, and cannot start or end with a hyphen."
  }
}

variable "pools" {
  description = "Map of storage pools to create"
  type = map(object({
    type    = string
    path    = string
    content = list(string)
    enabled = optional(bool, true)
    comment = optional(string)
  }))
  default = {}

  validation {
    condition     = alltrue([
      for name, pool in var.pools : can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$", name))
    ])
    error_message = "Storage pool names must be alphanumeric with optional hyphens, and cannot start or end with a hyphen."
  }

  validation {
    condition     = alltrue([
      for pool in var.pools : contains(["lvm", "lvmthin", "nfs", "cifs", "dir", "rbd", "zfs"], pool.type)
    ])
    error_message = "Storage type must be one of: lvm, lvmthin, nfs, cifs, dir, rbd, zfs"
  }

  validation {
    condition     = alltrue([
      for pool in var.pools : alltrue([
        for c in pool.content : contains(["images", "rootdir", "iso", "vztmpl", "snippets", "backup"], c)
      ])
    ])
    error_message = "Content types must be one or more of: images, rootdir, iso, vztmpl, snippets, backup"
  }
}

variable "volumes" {
  description = "Map of storage volumes to create"
  type = map(object({
    datastore_id = string
    size    = string
    format  = string
    comment = optional(string)
  }))
  default = {}

  validation {
    condition     = alltrue([
      for name, volume in var.volumes : can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$", name))
    ])
    error_message = "Volume names must be alphanumeric with optional hyphens, and cannot start or end with a hyphen."
  }

  validation {
    condition     = alltrue([
      for volume in var.volumes : can(regex("^[0-9]+[KMGTP]?$", volume.size))
    ])
    error_message = "Volume size must be a number followed by an optional unit (K, M, G, T, P)."
  }

  validation {
    condition     = alltrue([
      for volume in var.volumes : contains(["raw", "qcow2", "vmdk"], volume.format)
    ])
    error_message = "Volume format must be one of: raw, qcow2, vmdk"
  }
} 