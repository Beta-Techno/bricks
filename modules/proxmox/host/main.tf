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
    proxmox_virtual_environment_firewall_rules.host_rules
  ]
} 