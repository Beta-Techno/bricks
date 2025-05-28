# Get node information
data "proxmox_virtual_environment_node" "node" {
  node_name = var.node_name
}

# Check ISO URLs before attempting download
data "http" "iso_head" {
  for_each = var.isos
  url      = each.value.source_url
  method   = "HEAD"
}

locals {
  iso_ok = {
    for name, attrs in var.isos :
    name => attrs if tonumber(data.http.iso_head[name].response_headers["Content-Length"]) > 2000000000
  }
}

# Download and manage ISOs
resource "proxmox_virtual_environment_file" "isos" {
  for_each = local.iso_ok

  node_name     = var.node_name
  datastore_id  = var.storage_pool
  content_type  = "iso"
  overwrite     = each.value.overwrite

  source_file {
    path = each.value.source_url
  }

  # If checksum is provided, verify it
  lifecycle {
    precondition {
      condition     = each.value.checksum == null || can(regex("^[a-fA-F0-9]{32,}$", each.value.checksum))
      error_message = "Checksum must be a valid MD5 or SHA256 hash."
    }
  }
} 