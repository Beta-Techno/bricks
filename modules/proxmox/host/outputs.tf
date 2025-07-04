output "api_url" {
  description = "The API URL for the Proxmox host"
  value       = var.api_endpoint
}

output "storage" {
  description = "The configured storage details"
  value = {
    local_lvm = "local-lvm"
  }
}

output "network" {
  description = "The configured network details"
  value = {
    bridge = "vmbr0"
    ports  = var.network_ports
  }
} 