variable "hostname" {
  description = "The hostname of the Proxmox host"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9-]*[a-zA-Z0-9]$", var.hostname))
    error_message = "The hostname must be alphanumeric with optional hyphens, and cannot start or end with a hyphen."
  }
}

variable "ip_address" {
  description = "The IP address of the Proxmox host"
  type        = string

  validation {
    condition     = can(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", var.ip_address))
    error_message = "The ip_address value must be a valid IPv4 address."
  }
}

variable "root_password" {
  description = "The root password for initial setup"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.root_password) >= 8
    error_message = "The root_password must be at least 8 characters long."
  }
}

variable "automation_password" {
  description = "The password for the automation user"
  type        = string
  sensitive   = true
  default     = ""

  validation {
    condition     = var.automation_password == "" || length(var.automation_password) >= 8
    error_message = "The automation_password must be at least 8 characters long if provided."
  }
}

variable "network_ports" {
  description = "The network ports to include in the bridge"
  type        = list(string)
  default     = ["eth0"]

  validation {
    condition     = alltrue([for port in var.network_ports : can(regex("^[a-zA-Z0-9]+$", port))])
    error_message = "Network port names must be alphanumeric."
  }
}

variable "ssh_port" {
  description = "The SSH port to use"
  type        = number
  default     = 22

  validation {
    condition     = var.ssh_port > 0 && var.ssh_port < 65536
    error_message = "The ssh_port must be between 1 and 65535."
  }
}

variable "storage_path" {
  description = "The path to the storage device for local-lvm"
  type        = string
  default     = "/dev/sda3"

  validation {
    condition     = can(regex("^/dev/[a-zA-Z0-9]+(?:[0-9]+)?$", var.storage_path))
    error_message = "The storage_path must be a valid device path (e.g., /dev/sda3)."
  }
}

variable "api_endpoint" {
  description = "The API endpoint for the Proxmox host"
  type        = string
} 