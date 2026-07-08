# Kali Linux Installation

## Create Kali VM on Laptop 2

- Download ISO: https://www.kali.org/get-kali/
- Create VM with 4 vCPU, 6 GB RAM, 80 GB disk
- Attach ISO and install
- Network: Internal Network (vboxnet0)
- Static IP: 10.10.10.40

## Post-Install

```bash
sudo apt update && sudo apt full-upgrade -y
sudo systemctl enable --now ssh
```

## Verify Connectivity

```bash
ping 10.10.10.10
ping 10.10.10.20
ping 10.10.10.30
```
