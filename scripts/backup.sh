#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="${BACKUP_DIR:-/home/mo/backups}"
DATE=$(date +%Y%m%d-%H%M%S)
LOG_DIR="$(dirname "$0")/../logs"

mkdir -p "$BACKUP_DIR" "$LOG_DIR"

echo "[$DATE] Starting backup..." | tee -a "$LOG_DIR/backup.log"

vms=(
  "wazuh-srv"
  "ubuntu-srv-1"
  "win10-target-1"
  "kali-attack"
  "ubuntu-srv-2"
  "win10-target-2"
)

for vm in "${vms[@]}"; do
  if vboxmanage showvminfo "$vm" &>/dev/null; then
    echo "  Exporting $vm..."
    vboxmanage export "$vm" -o "$BACKUP_DIR/${vm}-${DATE}.ova" 2>>"$LOG_DIR/backup.log"
    echo "    -> $BACKUP_DIR/${vm}-${DATE}.ova"
  else
    echo "  WARNING: $vm not found, skipping"
  fi
done

echo "[$DATE] Backup complete." | tee -a "$LOG_DIR/backup.log"
