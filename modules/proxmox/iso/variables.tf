variable "node_name" {
  description = "The name of the Proxmox node"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$", var.node_name))
    error_message = "The node_name must be alphanumeric with optional hyphens, and cannot start or end with a hyphen."
  }
}

variable "storage_pool" {
  description = "The storage pool to store ISOs in"
  type        = string
  default     = "local"

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$", var.storage_pool))
    error_message = "The storage_pool must be alphanumeric with optional hyphens, and cannot start or end with a hyphen."
  }
}

variable "isos" {
  description = "Map of ISOs to manage"
  type = map(object({
    source_url = string
    filename   = optional(string)
    checksum   = optional(string)
    overwrite  = optional(bool, false)
  }))

  validation {
    condition     = alltrue([
      for iso in var.isos : can(regex("^https?://", iso.source_url))
    ])
    error_message = "All ISO source URLs must be valid HTTP(S) URLs."
  }
} 