terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.14"
    }
  }
}

# Initial provider configuration using root password
provider "proxmox" {
  pm_api_url      = "https://${var.ip_address}:8006/api2/json"
  pm_user         = "root@pam"
  pm_password     = var.root_password
  pm_tls_insecure = true
}

# Create automation user
resource "proxmox_user" "automation" {
  userid   = "automation@pam"
  password = var.automation_password
  comment  = "Terraform automation user"
}

# Create API token for automation user
resource "proxmox_api_token" "automation" {
  userid  = proxmox_user.automation.userid
  comment = "Terraform automation token"
}

# Configure local storage using null_resource
resource "null_resource" "storage_setup" {
  triggers = {
    storage = "local-lvm"
  }

  provisioner "local-exec" {
    command = <<-EOT
      pvesm add local-lvm local --content images,rootdir,iso,vztmpl
    EOT
  }
}

# Configure network bridge using null_resource
resource "null_resource" "network_setup" {
  triggers = {
    bridge = "vmbr0"
  }

  provisioner "local-exec" {
    command = <<-EOT
      if ! brctl show | grep -q vmbr0; then
        brctl addbr vmbr0
        ip link set vmbr0 up
      fi
    EOT
  }
}

# Configure security settings using null_resource
resource "null_resource" "security_setup" {
  triggers = {
    ssh_port = var.ssh_port
  }

  provisioner "local-exec" {
    command = <<-EOT
      # Update SSH port
      sed -i "s/#Port 22/Port ${var.ssh_port}/" /etc/ssh/sshd_config
      
      # Configure firewall
      pve-firewall set --enable 1
      pve-firewall rule add --action ACCEPT --proto tcp --dport ${var.ssh_port}
      pve-firewall rule add --action ACCEPT --proto tcp --dport 8006
    EOT
  }
} 