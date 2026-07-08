# Firewall Configuration

## Host Firewall (UFW)

```bash
# Allow SSH only
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable
```

## VM Firewalls

### Ubuntu VMs

```bash
sudo ufw allow ssh
sudo ufw allow from 10.10.10.0/24
sudo ufw enable
```

### Windows VMs

Disable Windows Firewall for lab purposes, or configure rules to allow:
- Wazuh agent communication (port 1514/1515 to 10.10.10.10)
- RDP (3389)
- SMB (445) — for lateral movement exercises
