module "first_node" {
  source              = "./first-node"
  api_endpoint        = var.api_endpoint
  ip_address          = var.ip_address
  hostname            = var.hostname
  root_password       = var.root_password
  automation_password = var.automation_password
  network_ports       = var.network_ports
  ssh_port            = var.ssh_port
  ssh_public_key      = var.ssh_public_key
  storage_path        = var.storage_path
} 