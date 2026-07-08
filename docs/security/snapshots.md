# Snapshot Management

## Baseline Snapshots

Take a clean snapshot after initial VM setup and before each exercise.

```bash
# Using the snapshot script
./scripts/snapshot.sh create <vm-name> "Clean baseline - $(date +%Y-%m-%d)"
```

## Manual via CLI

```bash
vboxmanage snapshot <vm-name> take "baseline-$(date +%Y-%m-%d)"
```

## Restore

```bash
vboxmanage snapshot <vm-name> restore "baseline-YYYY-MM-DD"
```

## Snapshot Strategy

| State | When | Retention |
|-------|------|-----------|
| Baseline | After OS + tools installed | Keep permanently |
| Pre-exercise | Before each playbook run | Delete after cleanup |
| Post-exercise | After cleanup verified | Delete after review |

## List Snapshots

```bash
vboxmanage snapshot <vm-name> list
```
