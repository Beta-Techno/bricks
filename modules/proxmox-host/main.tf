# Create automation user
resource "proxmox_virtual_environment_user" "automation" {
  user_id = "automation@pam"
  comment = "Terraform automation user"
  enabled = true
}

# Create API token for automation user
resource "proxmox_virtual_environment_user_token" "automation" {
  user_id    = proxmox_virtual_environment_user.automation.user_id
  token_name = "terraform"
  comment    = "Terraform automation token"

  # Prevent accidental token destruction
  lifecycle {
    prevent_destroy = true
  }
}

# Configure firewall rules
resource "proxmox_virtual_environment_firewall_rules" "host_rules" {
  node_name = var.hostname

  rule {
    type    = "in"
    action  = "ACCEPT"
    proto   = "tcp"
    dport   = var.ssh_port
    comment = "Allow SSH"
  }

  rule {
    type    = "in"
    action  = "ACCEPT"
    proto   = "tcp"
    dport   = "8006"
    comment = "Allow Proxmox UI"
  }
} 