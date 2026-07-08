# Laptop 1 — Node Setup

## VMs to Create

| VM | OS | vCPU | RAM | Disk | IP |
|----|----|------|-----|------|----|
| wazuh-srv | Ubuntu 24.04 Server | 4 | 6 GB | 120 GB | 10.10.10.10 |
| ubuntu-srv-1 | Ubuntu 24.04 Server | 2 | 4 GB | 50 GB | 10.10.10.20 |
| win10-target-1 | Windows 10 Pro | 4 | 4 GB | 120 GB | 10.10.10.30 |

## Create VMs

For each VM:

```bash
vboxmanage createvm --name <vm-name> --ostype <type> --register
vboxmanage modifyvm <vm-name> --memory <ram-mb> --cpus <vcpu> --nic1 intnet
vboxmanage createhd --filename <vm-name>.vdi --size <disk-gb>
vboxmanage storagectl <vm-name> --name "SATA" --add sata --controller IntelAhci
vboxmanage storageattach <vm-name> --storagectl "SATA" --port 0 --device 0 --type hdd --medium <vm-name>.vdi
```

## OS Configuration

- Install Ubuntu Server with OpenSSH
- Configure static IP per addressing plan
- Run `apt update && apt upgrade`
- Take initial snapshot
