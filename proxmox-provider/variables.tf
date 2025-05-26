variable "pm_api_url" {
  description = "The URL of the Proxmox API"
  type        = string
}

variable "pm_user" {
  description = "The Proxmox user"
  type        = string
}

variable "pm_api_token_id" {
  description = "The API token ID"
  type        = string
}

variable "pm_api_token_secret" {
  description = "The API token secret"
  type        = string
  sensitive   = true
} 