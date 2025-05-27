variable "api_endpoint" {
  description = "The API endpoint for the Proxmox host"
  type        = string
}
 
variable "api_token" {
  description = "The API token for authentication in the format userid!tokenid=secret"
  type        = string
  sensitive   = true
}

variable "ip_address" {
  description = "The IP address of the Proxmox host"
  type        = string
}

variable "hostname" {
  description = "The hostname of the Proxmox node"
  type        = string
}

variable "root_password" {
  description = "The root password for the Proxmox host"
  type        = string
  sensitive   = true
}

variable "automation_password" {
  description = "The password for the automation user"
  type        = string
  sensitive   = true
}

variable "network_ports" {
  description = "List of network ports to configure"
  type        = list(string)
}

variable "ssh_port" {
  description = "The SSH port to use"
  type        = number
}

variable "ssh_public_key" {
  description = "The SSH public key for the VM user"
  type        = string
}

variable "storage_path" {
  description = "The path to the storage device for local-lvm"
  type        = string
}

variable "storage_vg" {
  description = "The name of the LVM volume group"
  type        = string
} 