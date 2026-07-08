# IP Addressing

## Lab Network — 10.10.10.0/24

| Device | IP | Subnet | Notes |
|--------|----|--------|-------|
| Gateway (Virtual) | 10.10.10.1 | /24 | Internal network gateway |
| Wazuh Server | 10.10.10.10 | /24 | SIEM, agent manager |
| Ubuntu Server 1 | 10.10.10.20 | /24 | Laptop 1 target |
| Windows 10 Target 1 | 10.10.10.30 | /24 | Laptop 1 target |
| Kali Linux | 10.10.10.40 | /24 | Attack node |
| Ubuntu Server 2 | 10.10.10.50 | /24 | Laptop 2 target |
| Windows 10 Target 2 | 10.10.10.60 | /24 | Laptop 2 target |

## DHCP / Static

- All VMs use static IPs within 10.10.10.0/24
- No DHCP server in the lab (manual assignment)
- NAT adapter (if used) assigned via VirtualBox DHCP on 10.0.2.0/24
