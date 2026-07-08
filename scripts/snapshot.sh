#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 {create|restore|list|delete} <vm-name> [snapshot-name]"
  exit 1
}

if [ $# -lt 2 ]; then
  usage
fi

ACTION="$1"
VM="$2"
SNAPSHOT="${3:-}"

case "$ACTION" in
  create)
    if [ -z "$SNAPSHOT" ]; then
      SNAPSHOT="snapshot-$(date +%Y%m%d-%H%M%S)"
    fi
    echo "Creating snapshot '$SNAPSHOT' for $VM..."
    vboxmanage snapshot "$VM" take "$SNAPSHOT" --description "Auto snapshot $(date)"
    ;;
  restore)
    if [ -z "$SNAPSHOT" ]; then
      echo "Error: snapshot name required for restore"
      usage
    fi
    echo "Restoring $VM to snapshot '$SNAPSHOT'..."
    vboxmanage snapshot "$VM" restore "$SNAPSHOT"
    ;;
  list)
    echo "Snapshots for $VM:"
    vboxmanage snapshot "$VM" list
    ;;
  delete)
    if [ -z "$SNAPSHOT" ]; then
      echo "Error: snapshot name required for delete"
      usage
    fi
    echo "Deleting snapshot '$SNAPSHOT' for $VM..."
    vboxmanage snapshot "$VM" delete "$SNAPSHOT"
    ;;
  *)
    usage
    ;;
esac
