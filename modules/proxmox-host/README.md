# Proxmox Host Module

This module configures a Proxmox host with:
- Automation user and API token
- Local storage
- Network bridge
- Security settings

## Usage

```hcl
module "proxmox_host" {
  source = "./proxmox-host"

  ip_address         = "10.0.0.10"
  root_password      = var.root_password
  automation_password = var.automation_password
  network_ports      = ["eth0"]
  ssh_port          = 22
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| ip_address | The IP address of the Proxmox host | string | - | yes |
| root_password | The root password for initial setup | string | - | yes |
| automation_password | The password for the automation user | string | - | yes |
| network_ports | The network ports to include in the bridge | list(string) | ["eth0"] | no |
| ssh_port | The SSH port to use | number | 22 | no |

## Outputs

| Name | Description |
|------|-------------|
| api_url | The API URL for the Proxmox host |
| automation_user | The automation user details |
| storage | The configured storage details |
| network | The configured network details | 