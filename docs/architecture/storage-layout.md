# Storage Layout

## Laptop 1 — 1 TB SSD

| Path | Size | Content |
|------|------|---------|
| `/home/user/VirtualBox VMs/` | ~700 GB | VM disk images |
| `/home/user/homelab-cyber-cluster/` | ~10 GB | Repository, configs, scripts |
| `/home/user/ISOs/` | ~100 GB | Installation ISOs |
| `/home/user/backups/` | ~100 GB | VM snapshots and exports |
| System + overhead | ~90 GB | Ubuntu OS |

## Laptop 2 — 1 TB SSD

| Path | Size | Content |
|------|------|---------|
| `/home/user/VirtualBox VMs/` | ~700 GB | VM disk images |
| `/home/user/homelab-cyber-cluster/` | ~10 GB | Repository, configs, scripts |
| `/home/user/ISOs/` | ~100 GB | Installation ISOs |
| `/home/user/backups/` | ~100 GB | VM snapshots and exports |
| System + overhead | ~90 GB | Ubuntu OS |

## Shared Storage (Future)

- NFS share between laptops for centralized ISO/backup storage
- Planned for Proxmox migration
