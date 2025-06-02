variable "user_id" {
  description = "The ID of the automation user (e.g., 'ops@pve')"
  type        = string
  default     = "automation@pam"

  validation {
    condition     = can(regex("^[^@]+@[^@]+$", var.user_id))
    error_message = "The user_id must be in the format 'user@realm'"
  }
}

variable "user_comment" {
  description = "Comment for the automation user"
  type        = string
  default     = "Terraform automation user"
}

variable "user_password" {
  description = "Password for the automation user"
  type        = string
  sensitive   = true
}

variable "token_id" {
  description = "ID for the API token"
  type        = string
  default     = "terraform"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", var.token_id))
    error_message = "The token_id can only contain alphanumeric characters, underscores, and hyphens"
  }
}

variable "token_comment" {
  description = "Comment for the API token"
  type        = string
  default     = "Used by Terraform runs"
}

variable "token_expiry" {
  description = "Expiry date for the API token (format: YYYY-MM-DD)"
  type        = string
  default     = null

  validation {
    condition     = var.token_expiry == null || can(regex("^\\d{4}-\\d{2}-\\d{2}$", var.token_expiry))
    error_message = "The token_expiry must be in the format YYYY-MM-DD or null"
  }
}

variable "terraform_admin_role_id" {
  description = "The ID of the TerraformAdmin role from the foundation module"
  type        = string
  default     = "TerraformAdmin"
}

variable "acl_propagate" {
  description = "Whether to propagate ACLs to child paths"
  type        = bool
  default     = true
} 