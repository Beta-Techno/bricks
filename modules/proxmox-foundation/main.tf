# Define the TerraformAdmin role with full cluster automation privileges
resource "proxmox_virtual_environment_role" "terraform_admin" {
  role_id    = "TerraformAdmin"
  privileges = var.terraform_admin_privileges
}

# Define the VMOperator role for day-2 operations
resource "proxmox_virtual_environment_role" "vm_operator" {
  role_id    = "VMOperator"
  privileges = var.vm_operator_privileges
}

# Define the ReadOnly role for auditors and monitoring
resource "proxmox_virtual_environment_role" "read_only" {
  role_id    = "ReadOnly"
  privileges = var.read_only_privileges
}

# Create base ACLs for each role
resource "proxmox_virtual_environment_acl" "terraform_admin_global" {
  path      = "/"
  roles     = [proxmox_virtual_environment_role.terraform_admin.role_id]
  propagate = var.acl_propagate
}

resource "proxmox_virtual_environment_acl" "vm_operator_global" {
  path      = "/"
  roles     = [proxmox_virtual_environment_role.vm_operator.role_id]
  propagate = var.acl_propagate
}

resource "proxmox_virtual_environment_acl" "read_only_global" {
  path      = "/"
  roles     = [proxmox_virtual_environment_role.read_only.role_id]
  propagate = var.acl_propagate
} 