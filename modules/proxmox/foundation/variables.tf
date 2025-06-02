variable "api_token" {
  description = "The API token for the automation user. If empty, a new token will be created."
  type        = string
  default     = ""
  sensitive   = true
}

variable "terraform_admin_privileges" {
  description = "List of privileges for the TerraformAdmin role"
  type        = list(string)
  default     = [
    # User management privileges
    "Permissions.Modify",  # Allows managing permissions cluster-wide
    "User.Modify",        # Allows managing users and their tokens
    
    # Existing privileges
    "Sys.Audit",                 # Good practice for logging
    "Sys.Modify",
    "Datastore.Audit",
    "Datastore.Allocate",
    "Datastore.AllocateSpace",
    "VM.Allocate",
    "VM.Config.CPU",
    "VM.Config.Memory",
    "VM.Config.Network",
    "VM.Config.Disk",
    "VM.Config.HWType",
    "VM.Config.Options",
    "VM.Config.Cloudinit",       # Required for cloud-init
    "VM.Config.CDROM",           # For ISO attachment
    "VM.PowerMgmt",
    "VM.Monitor",
    "Pool.Allocate",
    "SDN.Use",
    "SDN.Audit",
    "VM.Clone"
  ]
}

variable "vm_operator_privileges" {
  description = "List of privileges for the VMOperator role"
  type        = list(string)
  default     = [
    "Datastore.Audit",
    "VM.Allocate",
    "VM.Config.CPU",
    "VM.Config.Memory",
    "VM.Config.Network",
    "VM.Config.Disk",
    "VM.Config.HWType",
    "VM.Config.Options",
    "VM.PowerMgmt",
    "Pool.Allocate",
    "SDN.Use",
    "SDN.Audit",
    "VM.Clone",
    "VM.Monitor"
  ]
}

variable "read_only_privileges" {
  description = "List of privileges for the ReadOnly role"
  type        = list(string)
  default     = [
    "Sys.Audit",
    "Datastore.Audit",
    "Pool.Audit",
    "VM.Audit",
    "SDN.Audit"
  ]
}

variable "acl_propagate" {
  description = "Whether to propagate ACLs to child paths"
  type        = bool
  default     = true
} 