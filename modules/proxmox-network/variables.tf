variable "node_name" {
  description = "The name of the Proxmox node"
  type        = string
}

variable "bridges" {
  description = "Map of Linux bridges to create"
  type = map(object({
    vlan_aware = bool
    ports      = list(string)
    comment    = optional(string)
  }))
  default = {}
}

variable "vlans" {
  description = "Map of VLANs to create"
  type = map(object({
    vlan_id    = number
    interface  = string
    comment    = optional(string)
  }))
  default = {}
} 