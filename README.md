# Bricks: Infrastructure Modules

This directory contains reusable infrastructure modules ("bricks") for building and managing Proxmox infrastructure. Each brick is a self-contained component that can be composed to create robust, reproducible, and automated infrastructure.

## Architecture

### Core Modules

1. **proxmox-host/**
   - Initial host configuration
   - User and API token management
   - Storage configuration
   - Network setup
   - Security hardening

2. **proxmox-compute/**
   - VM management
   - Container management
   - Resource allocation
   - Template management

3. **proxmox-network/**
   - Bridge configuration
   - VLAN setup
   - Network security
   - DNS configuration

4. **proxmox-storage/**
   - Storage pool management
   - Volume configuration
   - Backup setup
   - Storage security

### Module Structure

Each module follows this structure:
```
module-name/
├── main.tf           # Main configuration
├── variables.tf      # Input variables
├── outputs.tf        # Output values
├── versions.tf       # Version constraints
└── README.md         # Module documentation
```

### Usage

1. **Host Configuration**
```hcl
module "proxmox_host" {
  source = "./proxmox-host"
  
  hostname     = "pve01"
  ip_address   = "10.0.0.10"
  root_password = var.root_password
}
```

2. **Compute Resources**
```hcl
module "proxmox_compute" {
  source = "./proxmox-compute"
  
  vms = {
    "vm1" = {
      cores  = 2
      memory = 4096
      disk   = "20G"
    }
  }
}
```

3. **Network Configuration**
```hcl
module "proxmox_network" {
  source = "./proxmox-network"
  
  bridges = {
    "vmbr0" = {
      vlan_aware = true
      ports      = ["eth0"]
    }
  }
}
```

4. **Storage Setup**
```hcl
module "proxmox_storage" {
  source = "./proxmox-storage"
  
  pools = {
    "local-lvm" = {
      type    = "lvm"
      content = ["images", "rootdir", "iso"]
    }
  }
}
```

## Best Practices

1. **State Management**
   - Use remote state
   - Enable state locking
   - Implement state encryption

2. **Security**
   - Use API tokens
   - Implement RBAC
   - Enable audit logging
   - Use secrets management

3. **Versioning**
   - Pin provider versions
   - Use semantic versioning
   - Document breaking changes

4. **Testing**
   - Unit tests for modules
   - Integration tests
   - Security validation

## Contributing

1. Follow the module structure
2. Document all variables and outputs
3. Include usage examples
4. Add proper validation
5. Implement error handling

## License

MIT 