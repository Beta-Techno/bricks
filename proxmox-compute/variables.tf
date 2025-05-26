variable "api_url" {
  description = "The API URL for the Proxmox host"
  type        = string
}

variable "automation_user" {
  description = "The automation user details"
  type = object({
    userid        = string
    token_id      = string
    token_secret  = string
  })
  sensitive = true
}

variable "target_node" {
  description = "The target Proxmox node"
  type        = string
}

variable "network_bridge" {
  description = "The network bridge to use"
  type        = string
  default     = "vmbr0"
}

variable "network_gateway" {
  description = "The network gateway"
  type        = string
}

variable "storage_pool" {
  description = "The storage pool to use"
  type        = string
  default     = "local-lvm"
}

variable "vms" {
  description = "Map of VMs to create"
  type = map(object({
    vmid       = number
    template   = string
    cores      = number
    sockets    = number
    memory     = number
    disk       = string
    ip         = string
    ciuser     = string
    cipassword = string
    sshkeys    = string
    tags       = list(string)
  }))
  default = {}
}

variable "containers" {
  description = "Map of containers to create"
  type = map(object({
    template  = string
    cores     = number
    memory    = number
    swap      = number
    disk      = string
    ip        = string
    tags      = list(string)
  }))
  default = {}
} 