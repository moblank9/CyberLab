# Host Setup

## Prerequisites

- Ubuntu 24.04 LTS installed on both laptops
- User with sudo access
- SSH server enabled

## Steps

1. Install system updates

```bash
sudo apt update && sudo apt upgrade -y
```

2. Install essential packages

```bash
sudo apt install -y curl wget git vim net-tools openssh-server htop iotop
```

3. Configure SSH

```bash
sudo ufw allow ssh
sudo systemctl enable --now ssh
```

4. Set hostname

```bash
sudo hostnamectl set-hostname hypervisor-1   # Laptop 1
sudo hostnamectl set-hostname worker-1       # Laptop 2
```

5. Verify

```bash
uname -a
ip a
ssh localhost
```
