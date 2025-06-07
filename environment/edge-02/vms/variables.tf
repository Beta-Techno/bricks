variable "api_endpoint" {
  description = "The Proxmox API endpoint"
  type        = string
}

variable "hostname" {
  description = "The hostname of the Proxmox node"
  type        = string
}

variable "ssh_keys" {
  description = "List of SSH public keys to add to VMs"
  type        = list(string)
  default     = []
} 