# Shared Storage Configuration

## NFS (Optional)

If both laptops are on the same physical network, NFS can share ISO and backup directories.

### Host Setup (Laptop 1 — Server)

```bash
sudo apt install -y nfs-kernel-server
sudo mkdir -p /srv/nfs/ISOs /srv/nfs/backups
sudo chown nobody:nogroup /srv/nfs/ISOs /srv/nfs/backups
sudo chmod 777 /srv/nfs/ISOs /srv/nfs/backups
```

Export:

```bash
echo "/srv/nfs/ISOs    10.10.10.0/24(rw,sync,no_subtree_check)" | sudo tee -a /etc/exports
echo "/srv/nfs/backups 10.10.10.0/24(rw,sync,no_subtree_check)" | sudo tee -a /etc/exports
sudo exportfs -a
sudo systemctl restart nfs-kernel-server
```

### Client Mount (Laptop 2)

```bash
sudo apt install -y nfs-common
sudo mkdir -p /mnt/nfs/ISOs /mnt/nfs/backups
sudo mount -t nfs 10.10.10.1:/srv/nfs/ISOs /mnt/nfs/ISOs
sudo mount -t nfs 10.10.10.1:/srv/nfs/backups /mnt/nfs/backups
```

Add to `/etc/fstab` for persistence.
