# Example VM configuration
module "example_vm" {
  source = "../../modules/proxmox/vm"

  node_name = var.hostname
  vm_id     = 100
  name      = "example-vm"
  description = "Example VM created with Terraform"

  cpu = {
    cores   = 2
    sockets = 1
    type    = "host"
  }

  memory = 2048

  disk = {
    size     = 20
    storage  = "local-lvm"
    type     = "scsi"
    ssd      = true
    discard  = true
  }

  network = {
    bridge = "vmbr0"
    model  = "virtio"
    tag    = null
  }

  iso = {
    storage = "local"
    file    = "ubuntu-22.04.5-live-server-amd64.iso"
  }

  cloud_init = {
    user_data = <<-EOT
      #cloud-config
      package_update: true
      package_upgrade: true
      packages:
        - qemu-guest-agent
    EOT
  }

  ssh_keys = var.ssh_keys

  ip_config = {
    ip      = "10.1.10.100/24"
    gateway = "10.1.10.1"
    dns     = ["8.8.8.8", "8.8.4.4"]
  }
}

output "debug_disk" {
  value = module.example_vm.disk
} 