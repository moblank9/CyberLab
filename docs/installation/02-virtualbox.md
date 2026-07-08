# VirtualBox Installation

## Install VirtualBox and Extension Pack

```bash
# Add Oracle repository
wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --dearmor -o /usr/share/keyrings/oracle_vbox.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle_vbox.gpg] https://download.virtualbox.org/virtualbox/debian noble contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list

# Install
sudo apt update
sudo apt install -y virtualbox-7.1

# Download and install Extension Pack
wget https://download.virtualbox.org/virtualbox/7.1.4/Oracle_VM_VirtualBox_Extension_Pack-7.1.4.vbox-extpack
sudo vboxmanage extpack install Oracle_VM_VirtualBox_Extension_Pack-7.1.4.vbox-extpack
```

## Create Internal Network

```bash
vboxmanage hostonlyif create
vboxmanage hostonlyif ipconfig vboxnet0 --ip 10.10.10.1 --netmask 255.255.255.0
```

## Create NAT Network (temporary/optional)

```bash
vboxmanage natnetwork add --netname lab-nat --network "10.0.2.0/24" --enable --dhcp on
```

## Verify

```bash
vboxmanage list hostonlyifs
vboxmanage list natnets
```
