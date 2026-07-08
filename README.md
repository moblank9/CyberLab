# Homelab Cyber Cluster

Enterprise-grade homelab cyber range built on two laptops running VirtualBox, designed for red/blue team training, malware analysis, and incident response exercises.

## Hardware

|   Node   |        CPU        |     RAM    |  Storage |                           Role                         |
|----------|-------------------|------------|----------|--------------------------------------------------------|
| Laptop 1 | Intel i7 10th Gen | 16 GB DDR4 | 1 TB SSD | Hypervisor, Wazuh, Domain Services, Cluster Controller |
| Laptop 2 | Intel i7 8th Gen  | 16 GB DDR4 | 1 TB SSD | Attack Node, Kali, Overflow Compute                    |

## Objectives

- Provide an isolated, reproducible cyber range for security training
- Document every component for rapid rebuild and knowledge transfer
- Enable automated provisioning via Ansible and Terraform
- Support expansion to Proxmox, Docker, and Kubernetes

## Network

```
10.10.10.0/24  — Internal Lab Network (Host-Only / Internal)
```

|      Role     |      IP     |       VM      |   Host   |
|---------------|-------------|---------------|----------|
| Gateway       | 10.10.10.1  | —             | Virtual  |
| Wazuh         | 10.10.10.10 | Wazuh Server  | Laptop 1 |
| Ubuntu Server | 10.10.10.20 | Ubuntu Server | Laptop 1 |
| Windows 10    | 10.10.10.30 | Windows 10    | Laptop 1 |
| Kali Linux    | 10.10.10.40 | Kali Linux    | Laptop 2 |
| Ubuntu Worker | 10.10.10.50 | Ubuntu Server | Laptop 2 |

## VM Distribution

### Laptop 1
|       VM      |  vCPU  |    RAM    |    Disk    |
|---------------|--------|-----------|------------|
| Wazuh         | 4      | 6 GB      | 120 GB     |
| Ubuntu Server | 2      | 4 GB      | 50 GB      |
| Windows 10    | 4      | 4 GB      | 120 GB     |
| **Total**     | **10** | **14 GB** | **290 GB** |

### Laptop 2
|      VM       |  vCPU  |    RAM    |    Disk    |
|---------------|--------|-----------|------------|
| Kali Linux    | 4      | 6 GB      | 80 GB      |
| Ubuntu Server | 2      | 4 GB      | 50 GB      |
| Windows 10    | 4      | 4 GB      | 120 GB     |
| **Total**     | **10** | **14 GB** | **250 GB** |

## Getting Started

See [docs/installation/01-host-setup.md](docs/installation/01-host-setup.md) for initial host configuration.

## Roadmap

- [x] Directory structure and documentation framework
- [ ] VirtualBox and network configuration
- [ ] VM provisioning (Ansible)
- [ ] Wazuh SIEM deployment
- [ ] Kali Linux attack node
- [ ] Windows 10 target
- [ ] Cyber playbooks
- [ ] Backup and snapshot automation
- [ ] Docker/Kubernetes expansion
- [ ] Proxmox migration

## Future Improvements

- Proxmox cluster
- Docker / Kubernetes
- Elastic Stack / Splunk
- Active Directory
- Security Onion / Velociraptor
- TheHive / Cortex
- pfSense firewall
- Vulnerable applications (DVWA, Metasploitable, OWASP Juice Shop)
- GitHub Actions for documentation validation
- Grafana / Prometheus monitoring
