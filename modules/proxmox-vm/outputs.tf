output "id" {
  description = "The ID of the created VM"
  value       = proxmox_virtual_environment_vm.vm.id
}

output "name" {
  description = "The name of the created VM"
  value       = proxmox_virtual_environment_vm.vm.name
}

output "ip_address" {
  description = "The IP address of the VM (if configured)"
  value       = var.ip_config != null ? var.ip_config.ip : null
}

output "status" {
  description = "The current status of the VM"
  value       = proxmox_virtual_environment_vm.vm.status
}

output "node_name" {
  description = "The node where the VM is running"
  value       = proxmox_virtual_environment_vm.vm.node_name
} 