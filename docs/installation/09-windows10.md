# Windows 10 Installation

## Create Windows 10 VM

- Download Windows 10 ISO from Microsoft
- Create VM with 4 vCPU, 4 GB RAM, 120 GB disk
- Attach ISO and install
- Network: Internal Network (vboxnet0)
- Static IP: 10.10.10.30 (Laptop 1) / 10.10.10.60 (Laptop 2)

## Post-Install Configuration

1. Disable Windows Defender (for lab purposes)
2. Disable Windows Firewall (for attack exercises)
3. Enable Remote Desktop
4. Create local admin user: `lab\lab`
5. Install VirtualBox Guest Additions
6. Install Wazuh agent (point to 10.10.10.10)

## Configure Static IP

```
Network and Sharing Center → Change adapter settings →
IPv4 → Use the following IP:
  IP: 10.10.10.30
  Mask: 255.255.255.0
  Gateway: 10.10.10.1
  DNS: 8.8.8.8
```

## Snapshot

After configuration is complete, take a clean baseline snapshot.
