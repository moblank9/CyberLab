# Cluster Overview

## Purpose

Two-laptop homelab cyber range for red/blue team exercises, malware analysis, and incident response training.

## Nodes

| Node | Hostname | IP (Management) | Role |
|------|----------|-----------------|------|
| Laptop 1 | hypervisor-1 | 10.10.10.1 | Primary hypervisor, Wazuh, controller |
| Laptop 2 | worker-1 | 10.10.10.2 | Attack node, worker |

## Virtual Network

- **Network**: 10.10.10.0/24
- **Type**: VirtualBox Internal Network (isolated)
- **NAT**: Temporary adapter on select VMs for updates only

## VM Distribution

See [vm-layout.md](vm-layout.md) for detailed allocation.

## Security Boundaries

- Lab network is completely isolated from home network
- No VM has direct access to the internet by default
- NAT is enabled temporarily only on update-gateway VMs
- All VMs are snapshotted before exercises
