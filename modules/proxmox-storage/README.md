# Proxmox Storage Module

This module manages storage configuration for Proxmox hosts, including storage pools and volumes.

## Features

- Storage pool management
- Volume configuration
- Storage security settings
- Storage pool monitoring

## Usage

```hcl
module "proxmox_storage" {
  source = "../../../modules/proxmox-storage"
  
  node_name = "pve"
  
  pools = {
    "local-lvm" = {
      type    = "lvm"
      path    = "/dev/sda3"
      content = ["images", "rootdir", "iso"]
      comment = "Local LVM storage for VMs"
    }
  }
  
  volumes = {
    "vm-100-disk-0" = {
      storage = "local-lvm"
      size    = "20G"
      format  = "raw"
      comment = "Disk for VM 100"
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| node_name | The name of the Proxmox node | `string` | n/a | yes |
| pools | Map of storage pools to create | `map(object)` | `{}` | no |
| volumes | Map of storage volumes to create | `map(object)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| pools | Map of created storage pools |
| volumes | Map of created storage volumes |

## Notes

- Storage pool names must be unique
- Volume names must be unique per storage pool
- Storage paths must exist before being used
- Supported storage types: lvm, lvmthin, nfs, cifs, dir 