# Privilege Escalation Playbook

## Objective
Escalate privileges on a target VM and detect the activity.

## Targets
- Ubuntu Server 1 (10.10.10.20) — Linux
- Windows 10 (10.10.10.30) — Windows

## Steps

1. **Initial Foothold**
   - Gain low-privilege access to target

2. **Linux Escalation**
   - Kernel exploits
   - SUID binaries
   - Sudo misconfigurations
   - Cron job abuse

3. **Windows Escalation**
   - UAC bypass
   - Service misconfigurations
   - Token manipulation
   - DLL hijacking

4. **Detection**
   - Wazuh alerts on:
     - Privileged command execution
     - Security log clearing
     - New admin accounts
     - Modified system binaries

5. **Cleanup**
   - Restore snapshots
