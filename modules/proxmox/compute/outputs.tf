output "vms" {
  description = "Map of created VMs with their details"
  value = {
    for k, v in proxmox_virtual_environment_vm.vms : k => {
      id  = v.vm_id
      ip  = try(v.initialization[0].ip_config[0].ipv4[0].address, null)
    }
  }
}

output "containers" {
  description = "Map of created containers with their details"
  value = {
    for k, v in proxmox_virtual_environment_container.containers : k => {
      id  = v.vm_id
      ip  = try(v.initialization[0].ip_config[0].ipv4[0].address, null)
    }
  }
} 