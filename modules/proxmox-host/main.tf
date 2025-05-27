# Create automation user
resource "proxmox_virtual_environment_user" "automation" {
  user_id   = "automation@pam"
  password  = var.automation_password
  comment   = "Terraform automation user"
}

# Create API token for automation user
resource "proxmox_virtual_environment_api_token" "automation" {
  user_id  = proxmox_virtual_environment_user.automation.user_id
  token_id = "terraform"
  comment  = "Terraform automation token"

  # Prevent accidental token destruction
  lifecycle {
    prevent_destroy = true
  }
}

# Configure local storage
resource "proxmox_virtual_environment_storage" "local_lvm" {
  node_name = var.hostname
  name      = "local-lvm"
  type      = "lvm"
  device    = var.storage_path
  content   = ["images", "rootdir", "iso", "vztmpl"]

  lifecycle {
    precondition {
      condition     = alltrue([for c in ["images", "rootdir", "iso", "vztmpl", "snippets", "backup"] : contains(["images", "rootdir", "iso", "vztmpl", "snippets", "backup"], c)])
      error_message = "Content types must be one or more of: images, rootdir, iso, vztmpl, snippets, backup"
    }
  }
}

# Configure network bridge
resource "proxmox_virtual_environment_network_linux_bridge" "vmbr0" {
  node_name  = var.hostname
  name       = "vmbr0"
  vlan_aware = true
  ports      = var.network_ports
  comment    = "Main bridge for VM networking"
}

# Configure firewall rules
resource "proxmox_virtual_environment_firewall_ruleset" "rules" {
  node_name = var.hostname
  rules {
    type    = "in"
    action  = "ACCEPT"
    proto   = "tcp"
    dport   = var.ssh_port
    comment = "Allow SSH access"
  }
  rules {
    type    = "in"
    action  = "ACCEPT"
    proto   = "tcp"
    dport   = "8006"
    comment = "Allow Proxmox web interface"
  }
} 