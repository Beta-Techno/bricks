variable "api_url" {
  description = "The API URL for the Proxmox host"
  type        = string
}

variable "automation_user" {
  description = "The automation user details"
  type = object({
    userid        = string
    token_id      = string
    token_secret  = string
  })
  sensitive = true
} 