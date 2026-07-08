# Recovery

## VM Recovery

If a VM is compromised or broken:

```bash
# Restore to last known good snapshot
vboxmanage snapshot <vm-name> restore "baseline-YYYY-MM-DD"

# Or restore via script
./scripts/restore.sh <vm-name> <snapshot-name>
```

## Host Recovery

If host OS needs reinstallation:

1. Reinstall Ubuntu 24.04 LTS
2. Clone repository: `git clone <repo-url>`
3. Run installation steps from [01-host-setup.md](../installation/01-host-setup.md)
4. Import VMs from backup or recreate via automation

## Backup Verification

Run a restore test quarterly to ensure backups are valid.
