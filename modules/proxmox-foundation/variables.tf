variable "terraform_admin_privileges" {
  description = "List of privileges for the TerraformAdmin role"
  type        = list(string)
  default     = [
    "Sys.Audit",
    "Sys.Modify",
    "Datastore.Allocate",
    "Datastore.AllocateSpace",
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