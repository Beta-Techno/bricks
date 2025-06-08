variable "api_endpoint" {
  description = "The API endpoint for the Proxmox host"
  type        = string
}

variable "ip_address" {
  description = "The IP address of the Proxmox host"
  type        = string
  validation {
    condition     = can(regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$", var.ip_address))
    error_message = "The ip_address value must be a valid IPv4 address."
  }
}

variable "hostname" {
  description = "Hostname of the Proxmox node"
  type        = string
  default     = "pve-edge02"
  validation {
    condition     = can(regex("^[a-z0-9]([-a-z0-9]*[a-z0-9])?$", var.hostname))
    error_message = "The hostname must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "root_password" {
  description = "The root password for the Proxmox host"
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.root_password) >= 8
    error_message = "The root password must be at least 8 characters long."
  }
}

variable "network_ports" {
  description = "List of network ports to configure"
  type        = list(string)
  default     = ["enp1s0"]
  validation {
    condition     = alltrue([for port in var.network_ports : can(regex("^[a-z0-9]+$", port))])
    error_message = "Network ports must contain only lowercase letters and numbers."
  }
}

variable "ssh_port" {
  description = "The SSH port to use"
  type        = number
  default     = 22
  validation {
    condition     = var.ssh_port > 0 && var.ssh_port < 65536
    error_message = "The SSH port must be between 1 and 65535."
  }
}

variable "root_ssh_public_key" {
  description = "The SSH public key for root user access"
  type        = string
  default     = ""
  validation {
    condition     = var.root_ssh_public_key == "" || can(regex("^ssh-rsa|^ssh-ed25519|^ssh-dss|^ecdsa-sha2-nistp", var.root_ssh_public_key))
    error_message = "The root_ssh_public_key must be a valid SSH public key starting with ssh-rsa, ssh-ed25519, ssh-dss, or ecdsa-sha2-nistp."
  }
}

variable "ssh_public_key" {
  description = "The SSH public key for the VM user"
  type        = string
  default     = null
  validation {
    condition     = var.ssh_public_key == null || can(regex("^ssh-(rsa|ed25519|dss|ecdsa-sha2-nistp) AAAA[0-9A-Za-z+/]+[=]{0,3} ([^@]+@[^@]+)$", var.ssh_public_key))
    error_message = "The ssh_public_key must be a valid SSH public key."
  }
}

variable "api_token" {
  description = "The API token for the automation user"
  type        = string
  sensitive   = true
  default     = ""
  }

variable "automation_password" {
  description = "Password for the automation user"
  type        = string
  sensitive   = true
}

variable "storage_path" {
  description = "Path to the storage pool"
  type        = string
  default     = "/var/lib/vz"
}

variable "storage_vg" {
  description = "The name of the LVM volume group"
  type        = string
  default     = "pve"
}

variable "node_name" {
  type    = string
  default = "pve-edge01"
} 