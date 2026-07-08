# Networking Configuration

## Host Network

Each host connects to the physical network via Wi-Fi or Ethernet for management.

## VirtualBox Networks

### Internal Network (vboxnet0)
- **Network**: 10.10.10.0/24
- **DHCP**: Disabled
- **All VM traffic**: Isolated within this network

### NAT Network (Optional)
- **Network**: 10.0.2.0/24
- **DHCP**: Enabled via VirtualBox
- **Purpose**: Temporary internet access for specific VMs (updates only)

## Guest VM Network Configuration

Each VM should have:
- Adapter 1: Internal Network (vboxnet0) — Static IP in 10.10.10.0/24
- Adapter 2 (conditional): NAT — Only enabled during update windows

Example Ubuntu netplan config for VMs:

```yaml
# /etc/netplan/01-netcfg.yaml
network:
  version: 2
  ethernets:
    enp0s3:
      addresses:
        - 10.10.10.XX/24
      routes:
        - to: default
          via: 10.10.10.1
      nameservers:
        addresses: [8.8.8.8, 1.1.1.1]
```

## Isolation

- No VM should have both Internal and NAT adapters enabled simultaneously
- NAT adapter is only enabled during scheduled maintenance/update windows
- All playbook exercises run exclusively on the Internal network
