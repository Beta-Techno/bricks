# Bricks: Infrastructure Modules

This directory contains reusable infrastructure modules ("bricks") for building and managing Proxmox infrastructure. Each brick is a self-contained component that can be composed to create robust, reproducible, and automated infrastructure.

## Architecture

### Core Modules

1. **proxmox-host/**
   - Initial host configuration
   - User and API token management
   - Security hardening
   - Network setup

2. **proxmox-compute/**
   - VM management
   - Resource allocation
   - Template management
   - Storage configuration

3. **proxmox-network/**
   - Bridge configuration
   - VLAN setup
   - Network security (firewall rules, access control)
   - Network interface management

4. **proxmox-storage/**
   - Storage pool management
   - Volume configuration
   - Storage security (access control, encryption)
   - Storage pool monitoring

### Module Structure

Each module follows this structure:
```