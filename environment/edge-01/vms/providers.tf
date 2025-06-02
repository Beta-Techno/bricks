terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = ">= 0.46.0"
    }
  }
  required_version = ">= 1.0.0"
}

data "terraform_remote_state" "host" {
  backend = "local"
  config = {
    path = "${path.module}/../host/terraform.tfstate"
  }
}

provider "proxmox" {
  endpoint  = var.api_endpoint
  api_token = data.terraform_remote_state.host.outputs.automation_token
  insecure  = true
} 