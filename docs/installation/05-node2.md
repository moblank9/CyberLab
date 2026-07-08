# Laptop 2 — Node Setup

## VMs to Create

| VM | OS | vCPU | RAM | Disk | IP |
|----|----|------|-----|------|----|
| kali-attack | Kali Linux | 4 | 6 GB | 80 GB | 10.10.10.40 |
| ubuntu-srv-2 | Ubuntu 24.04 Server | 2 | 4 GB | 50 GB | 10.10.10.50 |
| win10-target-2 | Windows 10 Pro | 4 | 4 GB | 120 GB | 10.10.10.60 |

## Create VMs

For each VM:

```bash
vboxmanage createvm --name <vm-name> --ostype <type> --register
vboxmanage modifyvm <vm-name> --memory <ram-mb> --cpus <vcpu> --nic1 intnet
vboxmanage createhd --filename <vm-name>.vdi --size <disk-gb>
vboxmanage storagectl <vm-name> --name "SATA" --add sata --controller IntelAhci
vboxmanage storageattach <vm-name> --storagectl "SATA" --port 0 --device 0 --type hdd --medium <vm-name>.vdi
```

## Kali Linux Specific

- Download ISO from https://www.kali.org/get-kali/
- Default credentials: `kali:kali`
- Enable SSH: `sudo systemctl enable --now ssh`
- Update: `sudo apt update && sudo apt full-upgrade -y`
