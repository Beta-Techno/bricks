variable "node_name" {
  description = "The name of the Proxmox node to create the VM on"
  type        = string
}

variable "vm_id" {
  description = "The ID to assign to the VM"
  type        = number
}

variable "name" {
  description = "The name of the VM"
  type        = string
}

variable "description" {
  description = "Description of the VM"
  type        = string
  default     = ""
}

variable "template" {
  description = "Whether this is a template VM"
  type        = bool
  default     = false
}

variable "cpu" {
  description = "CPU configuration"
  type = object({
    cores   = number
    sockets = number
    type    = string
  })
  default = {
    cores   = 2
    sockets = 1
    type    = "host"
  }
}

variable "memory" {
  description = "Memory configuration in MB"
  type        = number
  default     = 2048
}

variable "disk" {
  description = "Disk configuration"
  type = object({
    size     = number
    storage  = string
    type     = string
    ssd      = bool
    discard  = bool
  })
  default = {
    size     = 20
    storage  = "local-lvm"
    type     = "scsi"
    ssd      = true
    discard  = true
  }
}

variable "network" {
  description = "Network configuration"
  type = object({
    bridge = string
    model  = string
    tag    = number
  })
  default = {
    bridge = "vmbr0"
    model  = "virtio"
    tag    = null
  }
}

variable "iso" {
  description = "ISO configuration"
  type = object({
    storage = string
    file    = string
  })
}

variable "cloud_init" {
  description = "Cloud-init configuration"
  type = object({
    user_data = string
    network_config = optional(string)
  })
  default = null
}

variable "ssh_keys" {
  description = "List of SSH public keys to add to the VM"
  type        = list(string)
  default     = []
}

variable "ip_config" {
  description = "IP configuration for the VM"
  type = object({
    ip       = string
    gateway  = string
    dns      = list(string)
  })
  default = null
}

variable "tags" {
  description = "Tags to apply to the VM"
  type        = list(string)
  default     = []
} 