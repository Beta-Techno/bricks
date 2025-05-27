ip_address         = "10.1.10.8"
hostname          = "pve_edge01"
root_password     = "TempPass1@"
automation_password = "OpsUser!2024$"
network_ports     = ["enp2s0"]  # Adjust this based on your network interface name
ssh_port          = 22
ssh_public_key    = ""  # Optional for now

# API configuration
api_endpoint      = "https://10.1.10.8:8006/api2/json"
api_token         = ""  # Will be populated after initial setup

# Storage configuration
storage_path      = "/dev/sda3"  # LVM physical volume
storage_vg        = "pve"        # Volume group name 