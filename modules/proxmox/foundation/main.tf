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
  role_id   = proxmox_virtual_environment_role.terraform_admin.role_id
  user_id   = proxmox_virtual_environment_user.automation.user_id
  propagate = var.acl_propagate
  depends_on = [proxmox_virtual_environment_user.automation]
}

resource "proxmox_virtual_environment_acl" "vm_operator_global" {
  path      = "/"
  role_id   = proxmox_virtual_environment_role.vm_operator.role_id
  user_id   = proxmox_virtual_environment_user.automation.user_id
  propagate = var.acl_propagate
  depends_on = [proxmox_virtual_environment_user.automation]
}

resource "proxmox_virtual_environment_acl" "read_only_global" {
  path      = "/"
  role_id   = proxmox_virtual_environment_role.read_only.role_id
  user_id   = proxmox_virtual_environment_user.automation.user_id
  propagate = var.acl_propagate
  depends_on = [proxmox_virtual_environment_user.automation]
}

# Add storage ACL for local-lvm
resource "proxmox_virtual_environment_acl" "automation_local_lvm" {
  path      = "/storage/local-lvm"
  role_id   = proxmox_virtual_environment_role.terraform_admin.role_id
  user_id   = proxmox_virtual_environment_user.automation.user_id
  propagate = false
  depends_on = [proxmox_virtual_environment_user.automation]
}

# Create automation user
resource "proxmox_virtual_environment_user" "automation" {
  user_id  = "automation@pve"
  comment  = "Terraform automation user"
  enabled  = true

  lifecycle {
    ignore_changes = [
      acl
    ]
  }
}

# Create API token for automation user
resource "proxmox_virtual_environment_user_token" "automation" {
  user_id               = proxmox_virtual_environment_user.automation.user_id
  token_name           = "terraform"
  comment              = "Terraform automation token"
  privileges_separation = false

  lifecycle {
    ignore_changes = [value]  # don't rotate unless we ask
  }
}

# If an external token is supplied, use it; otherwise use the one we created
locals {
  effective_token = var.api_token != "" ? var.api_token : proxmox_virtual_environment_user_token.automation.value
} 