#!/usr/bin/env bash
set -euo pipefail

echo "=== Lab Health Check ==="
echo ""

# Host resources
echo "--- Host Resources ---"
echo "CPU: $(nproc) cores"
mem_total=$(free -h | grep Mem | awk '{print $2}')
mem_avail=$(free -h | grep Mem | awk '{print $7}')
echo "Memory: $mem_avail available / $mem_total total"
disk_avail=$(df -h / | tail -1 | awk '{print $4}')
echo "Disk Available: $disk_avail"
echo ""

# VirtualBox status
echo "--- VirtualBox ---"
vboxmanage --version 2>/dev/null && echo "VirtualBox: OK" || echo "VirtualBox: NOT FOUND"
echo ""

# VM status
echo "--- VM Status ---"
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
    echo "  $vm: $state"
  else
    echo "  $vm: NOT FOUND"
  fi
done
echo ""

# Network reachability
echo "--- Network Reachability ---"
for ip in 10.10.10.10 10.10.10.20 10.10.10.30 10.10.10.40 10.10.10.50 10.10.10.60; do
  if ping -c 1 -W 1 "$ip" &>/dev/null; then
    echo "  $ip - OK"
  else
    echo "  $ip - UNREACHABLE"
  fi
done
echo ""

# Internet isolation check
echo "--- Internet Isolation ---"
if ping -c 1 -W 2 8.8.8.8 &>/dev/null; then
  echo "  WARNING: Internet is reachable from host!"
else
  echo "  Host is isolated from internet (expected)"
fi
echo ""

echo "=== Health check complete ==="
