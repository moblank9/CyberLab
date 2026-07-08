#!/usr/bin/env bash
set -euo pipefail

LAB_NET="10.10.10.0/24"

echo "Starting lab VMs..."

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
    state=$(vboxmanage showvminfo "$vm" --machinereadable | grep "^VMState=" | cut -d= -f2 | tr -d '"')
    if [ "$state" != "running" ]; then
      echo "  Starting $vm..."
      vboxmanage startvm "$vm" --type headless
    else
      echo "  $vm already running"
    fi
  else
    echo "  WARNING: $vm not found"
  fi
done

echo "All VMs started."
echo "Verifying connectivity..."
for ip in 10.10.10.10 10.10.10.20 10.10.10.30 10.10.10.40 10.10.10.50 10.10.10.60; do
  if ping -c 1 -W 1 "$ip" &>/dev/null; then
    echo "  $ip - OK"
  else
    echo "  $ip - UNREACHABLE"
  fi
done
