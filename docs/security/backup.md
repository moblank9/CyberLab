# Backup Strategy

## What to Backup

- VM disk images (.vdi files)
- VM configurations (.vbox files)
- Repository (configs, playbooks, docs)
- Wazuh configuration and alerts

## Backup Script

```bash
./scripts/backup.sh
```

By default, backs up to `/home/user/backups/`.

## Schedule

- VM snapshots: Before and after each exercise
- Full VM export: Weekly
- Repository backup: After each commit
- Config backup: On change

## Export VMs

```bash
vboxmanage export <vm-name> -o /home/user/backups/<vm-name>-$(date +%Y%m%d).ova
```
