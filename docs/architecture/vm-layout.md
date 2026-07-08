# VM Layout

## Laptop 1

| VM | vCPU | RAM | Disk | IP | Purpose |
|----|------|-----|------|----|---------|
| wazuh-srv | 4 | 6 GB | 120 GB | 10.10.10.10 | SIEM, monitoring |
| ubuntu-srv-1 | 2 | 4 GB | 50 GB | 10.10.10.20 | General server target |
| win10-target-1 | 4 | 4 GB | 120 GB | 10.10.10.30 | Windows attack target |
| **Total** | **10** | **14 GB** | **290 GB** | | |

## Laptop 2

| VM | vCPU | RAM | Disk | IP | Purpose |
|----|------|-----|------|----|---------|
| kali-attack | 4 | 6 GB | 80 GB | 10.10.10.40 | Offensive security |
| ubuntu-srv-2 | 2 | 4 GB | 50 GB | 10.10.10.50 | Secondary target |
| win10-target-2 | 4 | 4 GB | 120 GB | 10.10.10.60 | Additional target |
| **Total** | **10** | **14 GB** | **250 GB** | | |
