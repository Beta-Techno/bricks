output "vms" {
  description = "The created VMs"
  value = {
    for k, v in proxmox_vm_qemu.vms : k => {
      id     = v.vmid
      name   = v.name
      ip     = v.ipconfig0
      status = v.status
    }
  }
}

output "containers" {
  description = "The created containers"
  value = {
    for k, v in proxmox_lxc.containers : k => {
      id     = v.vmid
      name   = v.hostname
      ip     = v.network[0].ip
      status = v.status
    }
  }
} 