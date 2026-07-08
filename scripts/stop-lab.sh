#!/usr/bin/env bash
set -euo pipefail

echo "Stopping lab VMs..."

vms=(
  "win10-target-2"
  "ubuntu-srv-2"
  "kali-attack"
  "win10-target-1"
  "ubuntu-srv-1"
  "wazuh-srv"
)

for vm in "${vms[@]}"; do
  if vboxmanage showvminfo "$vm" &>/dev/null; then
    state=$(vboxmanage showvminfo "$vm" --machinereadable | grep "^VMState=" | cut -d= -f2 | tr -d '"')
    if [ "$state" == "running" ]; then
      echo "  Stopping $vm..."
      vboxmanage controlvm "$vm" acpipowerbutton
    else
      echo "  $vm not running"
    fi
  else
    echo "  WARNING: $vm not found"
  fi
done

echo "All VMs stopped."
