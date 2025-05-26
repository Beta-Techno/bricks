locals {
  # Common tags for all resources
  common_tags = {
    managed_by = "terraform"
    module     = "proxmox-compute"
  }

  # Default VM settings
  default_vm_settings = {
    cores    = 2
    sockets  = 1
    memory   = 4096
    disk     = "20G"
    template = "ubuntu-22.04-template"
  }

  # Default container settings
  default_container_settings = {
    cores    = 1
    memory   = 1024
    disk     = "8G"
    template = "ubuntu-22.04-standard"
  }

  # Merge default settings with provided settings
  vms = {
    for name, vm in var.vms : name => merge(local.default_vm_settings, vm)
  }

  containers = {
    for name, ct in var.containers : name => merge(local.default_container_settings, ct)
  }
} 