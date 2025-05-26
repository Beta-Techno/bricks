# Proxmox Environment Configuration

This directory contains the Terraform configurations for managing Proxmox infrastructure.

## Provider Configuration

The provider configuration is managed at the environment level, following Terraform best practices:

1. **First Node Setup** (`first-node/`):
   - Uses root credentials for initial setup
   - Creates automation user and API token
   - Outputs API URL and automation user details

2. **VM Management** (`first-vm/`):
   - Uses automation user credentials
   - Creates and manages VMs
   - Gets credentials from first-node outputs

## Usage

1. **Set up the Proxmox host**:
   ```bash
   cd first-node
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your values
   terraform init
   terraform apply
   ```

2. **Get the automation user details**:
   ```bash
   terraform output -raw automation_user
   ```

3. **Create VMs**:
   ```bash
   cd ../first-vm
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with the automation user details
   terraform init
   terraform apply
   ```

## Provider Configuration Details

### First Node (Root Access)
```hcl
provider "proxmox" {
  pm_api_url      = "https://${var.ip_address}:8006/api2/json"
  pm_user         = "root@pam"
  pm_password     = var.root_password
  pm_tls_insecure = true
}
```

### VM Management (Automation User)
```hcl
provider "proxmox" {
  pm_api_url          = var.api_url
  pm_user             = var.automation_user.userid
  pm_api_token_id     = var.automation_user.token_id
  pm_api_token_secret = var.automation_user.token_secret
  pm_tls_insecure     = true
}
```

## Security Notes

1. The `pm_tls_insecure = true` setting is for development only
2. In production, you should:
   - Use proper TLS certificates
   - Set `pm_tls_insecure = false`
   - Consider using a more secure authentication method 