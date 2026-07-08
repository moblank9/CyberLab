# Persistence Playbook

## Objective
Establish and detect persistence mechanisms on target VMs.

## Techniques

### Linux Persistence
- SSH authorized keys
- Cron job backdoors
- Systemd service modifications
- LD_PRELOAD hooks

### Windows Persistence
- Registry Run keys
- Scheduled tasks
- WMI event subscriptions
- Service DLL hijacking
- Startup folder entries

## Steps

1. **Deploy Persistence**
   - From Kali, establish persistence on target VM

2. **Detection**
   - Review Wazuh alerts
   - Check for:
     - New SSH keys
     - Unusual cron jobs
     - New scheduled tasks
     - Registry modifications
     - New services

3. **Remediation**
   - Remove persistence mechanisms
   - Restore from clean snapshot

4. **Documentation**
   - Record persistence method
   - Note detection gaps
