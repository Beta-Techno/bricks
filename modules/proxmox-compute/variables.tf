variable "target_node" {
  description = "The target Proxmox node"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$", var.target_node))
    error_message = "The target_node must be alphanumeric with optional hyphens, and cannot start or end with a hyphen."
  }
}

variable "network_bridge" {
  description = "The network bridge to use"
  type        = string
  default     = "vmbr0"

  validation {
    condition     = can(regex("^vmbr[0-9]+$", var.network_bridge))
    error_message = "The network_bridge must be in the format 'vmbrX' where X is a number."
  }
}

variable "network_gateway" {
  description = "The network gateway"
  type        = string

  validation {
    condition     = can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", var.network_gateway))
    error_message = "The network_gateway must be a valid IPv4 address."
  }
}

variable "storage_pool" {
  description = "The storage pool to use"
  type        = string
  default     = "local-lvm"

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$", var.storage_pool))
    error_message = "The storage_pool must be alphanumeric with optional hyphens, and cannot start or end with a hyphen."
  }
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
    network_model = optional(string, "virtio")
  }))
  default = {}

  validation {
    condition     = alltrue([
      for vm in var.vms : vm.vmid > 0 && vm.vmid < 999999999
    ])
    error_message = "VM IDs must be between 1 and 999999999."
  }

  validation {
    condition     = alltrue([
      for vm in var.vms : vm.cores > 0 && vm.cores <= 128
    ])
    error_message = "Number of cores must be between 1 and 128."
  }

  validation {
    condition     = alltrue([
      for vm in var.vms : vm.sockets > 0 && vm.sockets <= 4
    ])
    error_message = "Number of sockets must be between 1 and 4."
  }

  validation {
    condition     = alltrue([
      for vm in var.vms : vm.memory > 0 && vm.memory <= 1048576
    ])
    error_message = "Memory must be between 1 and 1048576 MB."
  }

  validation {
    condition     = alltrue([
      for vm in var.vms : can(regex("^[0-9]+[KMGTP]?$", vm.disk))
    ])
    error_message = "Disk size must be a number followed by an optional unit (K, M, G, T, P)."
  }

  validation {
    condition     = alltrue([
      for vm in var.vms : can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", vm.ip))
    ])
    error_message = "IP address must be a valid IPv4 address."
  }

  validation {
    condition     = alltrue([
      for vm in var.vms : can(regex("^[0-9]+$", vm.template))
    ])
    error_message = "Template ID must be a valid number."
  }

  validation {
    condition     = alltrue([
      for vm in var.vms : vm.network_model == null || contains(["virtio", "e1000", "rtl8139", "vmxnet3"], vm.network_model)
    ])
    error_message = "Network model must be one of: virtio, e1000, rtl8139, vmxnet3."
  }

  validation {
    condition     = alltrue([
      for vm in var.vms : length(vm.ciuser) > 0 && length(vm.ciuser) <= 32
    ])
    error_message = "Cloud-init username must be between 1 and 32 characters."
  }

  validation {
    condition     = alltrue([
      for vm in var.vms : length(vm.cipassword) >= 8
    ])
    error_message = "Cloud-init password must be at least 8 characters."
  }
}

variable "containers" {
  description = "Map of containers to create"
  type = map(object({
    vmid       = number
    template   = string
    cores      = number
    memory     = number
    swap       = number
    disk       = string
    ip         = string
    tags       = list(string)
    network_name = optional(string, "eth0")
  }))
  default = {}

  validation {
    condition     = alltrue([
      for container in var.containers : container.vmid > 0 && container.vmid < 999999999
    ])
    error_message = "Container IDs must be between 1 and 999999999."
  }

  validation {
    condition     = alltrue([
      for container in var.containers : container.cores > 0 && container.cores <= 128
    ])
    error_message = "Number of cores must be between 1 and 128."
  }

  validation {
    condition     = alltrue([
      for container in var.containers : container.memory > 0 && container.memory <= 1048576
    ])
    error_message = "Memory must be between 1 and 1048576 MB."
  }

  validation {
    condition     = alltrue([
      for container in var.containers : container.swap >= 0 && container.swap <= 1048576
    ])
    error_message = "Swap must be between 0 and 1048576 MB."
  }

  validation {
    condition     = alltrue([
      for container in var.containers : can(regex("^[0-9]+[KMGTP]?$", container.disk))
    ])
    error_message = "Disk size must be a number followed by an optional unit (K, M, G, T, P)."
  }

  validation {
    condition     = alltrue([
      for container in var.containers : can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", container.ip))
    ])
    error_message = "IP address must be a valid IPv4 address."
  }

  validation {
    condition     = alltrue([
      for container in var.containers : can(regex("^[0-9]+$", container.template))
    ])
    error_message = "Template ID must be a valid number."
  }

  validation {
    condition     = alltrue([
      for container in var.containers : container.network_name == null || can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$", container.network_name))
    ])
    error_message = "Network name must be alphanumeric with optional hyphens, and cannot start or end with a hyphen."
  }
} 