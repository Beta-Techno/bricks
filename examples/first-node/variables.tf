variable "ip_address" {
  description = "The IP address of your Proxmox host"
  type        = string
}

variable "root_password" {
  description = "The root password for initial setup"
  type        = string
  sensitive   = true
}

variable "automation_password" {
  description = "The password for the automation user"
  type        = string
  sensitive   = true
}

variable "network_ports" {
  description = "The network ports to include in the bridge"
  type        = list(string)
  default     = ["eth0"]
}

variable "ssh_port" {
  description = "The SSH port to use"
  type        = number
  default     = 22
}

variable "ssh_public_key" {
  description = "The SSH public key for the VM user"
  type        = string
} 