output "terraform_admin_role_id" {
  description = "The ID of the TerraformAdmin role"
  value       = proxmox_virtual_environment_role.terraform_admin.role_id
}

output "vm_operator_role_id" {
  description = "The ID of the VMOperator role"
  value       = proxmox_virtual_environment_role.vm_operator.role_id
}

output "read_only_role_id" {
  description = "The ID of the ReadOnly role"
  value       = proxmox_virtual_environment_role.read_only.role_id
}

output "terraform_admin_privileges" {
  description = "The privileges assigned to the TerraformAdmin role"
  value       = proxmox_virtual_environment_role.terraform_admin.privileges
}

output "vm_operator_privileges" {
  description = "The privileges assigned to the VMOperator role"
  value       = proxmox_virtual_environment_role.vm_operator.privileges
}

output "read_only_privileges" {
  description = "The privileges assigned to the ReadOnly role"
  value       = proxmox_virtual_environment_role.read_only.privileges
}

output "automation_user" {
  description = "The automation user details"
  value = {
    user_id = proxmox_virtual_environment_user.automation.user_id
    token   = local.effective_token
  }
  sensitive = true
} 