# Networking Troubleshooting

## VMs cannot ping each other

- Verify all VMs use the same Internal Network name
- Check static IP configuration
- Verify host firewall is not blocking vboxnet0
- Restart VirtualBox host-only adapter: `sudo vboxmanage hostonlyif ipconfig vboxnet0 --ip 10.10.10.1`

## VM cannot reach host

- Host-only adapter must be enabled on the VM
- Check host firewall: `sudo ufw status`

## VM has no internet (when NAT enabled)

- Verify NAT adapter is enabled in VM settings
- Check VirtualBox NAT network is running: `vboxmanage natnetwork list`
- Verify DHCP or static config on the VM's NAT interface
