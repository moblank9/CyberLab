#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 <vm-name> <backup-file>"
  echo "  Restore a VM from an OVA backup file"
  exit 1
}

if [ $# -ne 2 ]; then
  usage
fi

VM="$1"
BACKUP_FILE="$2"

if [ ! -f "$BACKUP_FILE" ]; then
  echo "Error: Backup file not found: $BACKUP_FILE"
  exit 1
fi

echo "Restoring $VM from $BACKUP_FILE..."

# Unregister existing VM if present
if vboxmanage showvminfo "$VM" &>/dev/null; then
  echo "  Unregistering existing VM: $VM"
  vboxmanage unregistervm "$VM" --delete
fi

# Import OVA
vboxmanage import "$BACKUP_FILE" --vsys 0 --vmname "$VM"

echo "Restore complete: $VM"
