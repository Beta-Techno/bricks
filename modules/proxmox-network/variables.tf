variable "node_name" {
  description = "The name of the Proxmox node"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$", var.node_name))
    error_message = "The node_name must be alphanumeric with optional hyphens, and cannot start or end with a hyphen."
  }
}

variable "bridges" {
  description = "Map of Linux bridges to create"
  type = map(object({
    vlan_aware = bool
    ports      = list(string)
    comment    = optional(string)
  }))
  default = {}

  validation {
    condition     = alltrue([
      for name, bridge in var.bridges : can(regex("^vmbr[0-9]+$", name))
    ])
    error_message = "Bridge names must be in the format 'vmbrX' where X is a number."
  }

  validation {
    condition     = alltrue([
      for bridge in var.bridges : alltrue([
        for port in bridge.ports : can(regex("^[a-zA-Z0-9]+$", port))
      ])
    ])
    error_message = "Bridge ports must be alphanumeric."
  }
}

variable "vlans" {
  description = "Map of VLANs to create"
  type = map(object({
    vlan_id    = number
    base_interface = string
    comment    = optional(string)
  }))
  default = {}

  validation {
    condition     = alltrue([
      for name, vlan in var.vlans : can(regex("^vlan[0-9]+$", name))
    ])
    error_message = "VLAN names must be in the format 'vlanX' where X is a number."
  }

  validation {
    condition     = alltrue([
      for vlan in var.vlans : can(regex("^[a-zA-Z0-9]+$", vlan.base_interface))
    ])
    error_message = "VLAN base interfaces must be alphanumeric."
  }
} 