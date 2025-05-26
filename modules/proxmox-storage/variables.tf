variable "node_name" {
  description = "The name of the Proxmox node"
  type        = string
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
}

variable "volumes" {
  description = "Map of storage volumes to create"
  type = map(object({
    storage = string
    size    = string
    format  = string
    comment = optional(string)
  }))
  default = {}
} 