# Bricks: Infrastructure Modules

This directory contains reusable infrastructure modules ("bricks") for building and managing Proxmox infrastructure. Each brick is a self-contained component that can be composed to create robust, reproducible, and automated infrastructure.

## Architecture

### Core Modules

1. **proxmox-host/**
   - Initial host configuration
   - User and API token management
   - Security hardening
   - Basic network setup (SSH)

2. **proxmox-network/**
   - Bridge configuration
   - VLAN setup
   - Network interface management
   - Network security settings

3. **proxmox-storage/**
   - Storage pool management
   - Volume configuration
   - Storage security settings
   - Storage pool monitoring

4. **proxmox-compute/**
   - VM management
   - Resource allocation
   - Template management
   - VM storage configuration

### Environment Structure

The `environments/` directory contains environment-specific configurations:

```
environments/
└── dev/
    ├── first-node/   # Initial Proxmox host setup
    │   ├── main.tf           # Host, network, and storage configuration
    │   ├── variables.tf      # Environment variables
    │   └── terraform.tfvars.example
    │
    └── first-vm/     # VM management
        ├── main.tf           # VM configuration
        ├── variables.tf      # Environment variables
        └── terraform.tfvars.example
```

### Usage

1. **Initial Host Setup** (`first-node/`):
   ```hcl
   # Configure the Proxmox provider
   provider "proxmox" {
     pm_api_url      = "https://${var.ip_address}:8006/api2/json"
     pm_user         = "root@pam"
     pm_password     = var.root_password
     pm_tls_insecure = true  # For development only
   }

   # Configure the host
   module "proxmox_host" {
     source = "../../../modules/proxmox-host"
     
     ip_address         = var.ip_address
     root_password      = var.root_password
     automation_password = var.automation_password
     network_ports      = var.network_ports
     ssh_port          = var.ssh_port
     ssh_public_key    = var.ssh_public_key
   }

   # Configure networking
   module "proxmox_network" {
     source = "../../../modules/proxmox-network"
     
     node_name = var.hostname
     bridges = {
       "vmbr0" = {
         vlan_aware = true
         ports      = var.network_ports
         comment    = "Main bridge for VM networking"
       }
     }
   }

   # Configure storage
   module "proxmox_storage" {
     source = "../../../modules/proxmox-storage"
     
     node_name = var.hostname
     pools = {
       "local-lvm" = {
         type    = "lvm"
         path    = "/dev/sda3"  # Adjust based on your disk layout
         content = ["images", "rootdir", "iso"]
         comment = "Local LVM storage for VMs"
       }
     }
   }
   ```

2. **VM Management** (`first-vm/`):
   ```hcl
   # Configure the Proxmox provider with automation user
   provider "proxmox" {
     pm_api_url          = var.api_url
     pm_user             = var.automation_user.userid
     pm_api_token_id     = var.automation_user.token_id
     pm_api_token_secret = var.automation_user.token_secret
     pm_tls_insecure     = true  # For development only
   }

   # Create VMs
   module "proxmox_compute" {
     source = "../../../modules/proxmox-compute"
     
     vms = {
       "vm1" = {
         cores  = 2
         memory = 4096
         disk   = "20G"
       }
     }
   }
   ```

## Best Practices

1. **Provider Configuration**
   - Configure providers at environment level
   - Use API tokens for automation
   - Enable TLS in production

2. **State Management**
   - Use remote state
   - Enable state locking
   - Implement state encryption

3. **Security**
   - Use API tokens instead of passwords
   - Implement RBAC
   - Enable audit logging
   - Use secrets management

4. **Versioning**
   - Pin provider versions
   - Use semantic versioning
   - Document breaking changes

## Contributing

1. Follow the module structure
2. Document all variables and outputs
3. Include usage examples
4. Add proper validation
5. Implement error handling

## License

MIT