# Proxmox Network Module

This module manages network configuration for Proxmox hosts, including Linux bridges and VLANs.

## Features

- Linux bridge configuration
- VLAN setup
- Network interface management
- Network security settings

## Usage

```hcl
module "proxmox_network" {
  source = "../../../modules/proxmox-network"
  
  node_name = "pve"
  
  bridges = {
    "vmbr0" = {
      vlan_aware = true
      ports      = ["eth0"]
      comment    = "Main bridge for VM networking"
    }
  }
  
  vlans = {
    "vlan100" = {
      vlan_id    = 100
      interface  = "vmbr0"
      comment    = "VLAN for internal network"
    }
  }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| node_name | The name of the Proxmox node | `string` | n/a | yes |
| bridges | Map of Linux bridges to create | `map(object)` | `{}` | no |
| vlans | Map of VLANs to create | `map(object)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| bridges | Map of created Linux bridges |
| vlans | Map of created VLANs |

## Notes

- Bridge names must be unique
- VLAN IDs must be unique per interface
- Network interfaces must exist before being used 