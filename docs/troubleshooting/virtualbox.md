# VirtualBox Troubleshooting

## VM fails to start

```bash
# Check logs
~/.config/VirtualBox/VBoxSVC.log
~/VirtualBox VMs/<vm>/Logs/VBox.log

# Common fixes
vboxmanage modifyvm <vm> --nested-hw-virt on
vboxmanage modifyvm <vm> --large-pages off
```

## USB not passing through

- Verify Extension Pack is installed: `vboxmanage list extpacks`
- Add user to vboxusers group: `sudo usermod -aG vboxusers $USER`

## Performance issues

- Enable VT-x/AMD-V in BIOS
- Reduce VM vCPU count if over-committing
- Increase host RAM if swapping
- Use SSD for VM storage
