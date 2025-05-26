variable "api_url" {
  description = "The API URL for the Proxmox host"
  type        = string
}

variable "automation_user" {
  description = "The automation user details"
  type = object({
    userid        = string
    token_id      = string
    token_secret  = string
  })
  sensitive = true
}

variable "target_node" {
  description = "The target Proxmox node"
  type        = string
  default     = "pve"
}

variable "vm_name" {
  description = "The name of the VM"
  type        = string
  default     = "test-vm"
}

variable "vm_id" {
  description = "The VM ID"
  type        = number
  default     = 100
}

variable "template_name" {
  description = "The name of the template to clone from"
  type        = string
  default     = "ubuntu-22.04-template"
}

variable "vm_cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "vm_sockets" {
  description = "Number of CPU sockets"
  type        = number
  default     = 1
}

variable "vm_memory" {
  description = "Amount of RAM in MB"
  type        = number
  default     = 2048
}

variable "vm_disk_size" {
  description = "Size of the VM disk"
  type        = string
  default     = "10G"
}

variable "network_bridge" {
  description = "The network bridge to use"
  type        = string
  default     = "vmbr0"
}

variable "storage_pool" {
  description = "The storage pool to use"
  type        = string
  default     = "local-lvm"
}

variable "ip_config" {
  description = "The IP configuration for the VM"
  type        = string
  default     = "ip=dhcp"
} 