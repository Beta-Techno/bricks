# Create the automation user
resource "proxmox_virtual_environment_user" "automation" {
  user_id  = var.user_id
  comment  = var.user_comment
  password = var.user_password
  enabled  = true
}

# Create API token for the automation user
resource "proxmox_virtual_environment_api_token" "automation" {
  user_id  = proxmox_virtual_environment_user.automation.user_id
  token_id = var.token_id
  comment  = var.token_comment
  expiry   = var.token_expiry

  # Prevent accidental token destruction
  lifecycle {
    prevent_destroy = true
  }
}

# Assign the TerraformAdmin role to the automation user
resource "proxmox_virtual_environment_acl" "automation" {
  path      = "/"
  roles     = [var.terraform_admin_role_id]
  users     = [proxmox_virtual_environment_user.automation.user_id]
  propagate = var.acl_propagate
} 