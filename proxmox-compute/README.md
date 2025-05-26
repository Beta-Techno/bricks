# Proxmox Compute Module

This module manages VMs and containers on a Proxmox host.

## Usage

```hcl
module "proxmox_compute" {
  source = "./proxmox-compute"

  api_url = module.proxmox_host.api_url
  automation_user = module.proxmox_host.automation_user
  target_node     = "pve"
  network_bridge  = "vmbr0"
  network_gateway = "10.0.0.1"
  storage_pool    = "local-lvm"

  vms = {
    "test-vm" = {
      vmid       = 100
      template   = "ubuntu-22.04-template"
      cores      = 2
      sockets    = 1
      memory     = 4096
      disk       = "20G"
      ip         = "10.0.0.100"
      ciuser     = "ubuntu"
      cipassword = var.vm_password
      sshkeys    = var.ssh_public_key
      tags       = ["test", "terraform"]
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| api_url | The API URL for the Proxmox host | string | - | yes |
| automation_user | The automation user details | object | - | yes |
| target_node | The target Proxmox node | string | - | yes |
| network_bridge | The network bridge to use | string | "vmbr0" | no |
| network_gateway | The network gateway | string | - | yes |
| storage_pool | The storage pool to use | string | "local-lvm" | no |
| vms | Map of VMs to create | map | {} | no |
| containers | Map of containers to create | map | {} | no |

## Outputs

| Name | Description |
|------|-------------|
| vms | The created VMs |
| containers | The created containers |
``` 