# Create automation user
resource "proxmox_virtual_environment_user" "automation" {
  user_id  = "automation@pam"
  comment  = "Terraform automation user"
  enabled  = true
  password = var.automation_password

  lifecycle {
    # the old provider versions left an `acl` attribute in state;
    # tell Terraform to ignore it so we don't need the two-step apply
    ignore_changes = [acl]
  }
}

# Create API token for automation user
resource "proxmox_virtual_environment_user_token" "automation" {
  count      = var.api_token == "" ? 1 : 0  # create only on first run
  user_id    = proxmox_virtual_environment_user.automation.user_id
  token_name = "terraform"
  comment    = "Terraform automation token"
  privileges_separation = false  # Disable privilege separation

  # Prevent accidental token destruction
  lifecycle {
    prevent_destroy = true
  }
}

# If an external token is supplied, use it; otherwise use the one we created
locals {
  effective_token = var.api_token != "" ? var.api_token : (length(proxmox_virtual_environment_user_token.automation) > 0 ? proxmox_virtual_environment_user_token.automation[0].value : "")
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

# Install SSH keys
resource "null_resource" "install_root_ssh_key" {
  count = var.root_ssh_public_key != "" ? 1 : 0

  connection {
    type     = "ssh"
    host     = var.ip_address
    user     = "root"
    password = var.root_password
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /root/.ssh",
      "chmod 700 /root/.ssh",
      "echo '${var.root_ssh_public_key}' >> /root/.ssh/authorized_keys",
      "chmod 600 /root/.ssh/authorized_keys"
    ]
  }

  depends_on = [proxmox_virtual_environment_firewall_rules.host_rules]
}

resource "null_resource" "install_automation_ssh_key" {
  count = var.automation_ssh_public_key != "" ? 1 : 0

  connection {
    type     = "ssh"
    host     = var.ip_address
    user     = "root"
    password = var.root_password
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/automation/.ssh",
      "chmod 700 /home/automation/.ssh",
      "echo '${var.automation_ssh_public_key}' >> /home/automation/.ssh/authorized_keys",
      "chmod 600 /home/automation/.ssh/authorized_keys",
      "chown -R automation:automation /home/automation/.ssh"
    ]
  }

  depends_on = [
    proxmox_virtual_environment_user.automation,
    proxmox_virtual_environment_firewall_rules.host_rules
  ]
} 