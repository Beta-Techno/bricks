/**
 * Import the default vmbr0 bridge that the Proxmox installer
 * puts on every node. This will only take effect on the first run
 * when the bridge isn't in state yet.
 */
import {
  to = module.proxmox_network.proxmox_virtual_environment_network_linux_bridge.bridges["vmbr0"]
  id = "pve-edge01:vmbr0"
} 