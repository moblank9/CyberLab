# Incident Response Playbook

## Objective
Simulate a full incident response lifecycle.

## Scenario
Alert from Wazuh indicates suspicious activity on Windows 10 target.

## IR Phases

### 1. Preparation
- Ensure snapshots are current
- Verify logging is enabled on all systems
- Confirm Wazuh is receiving events

### 2. Detection & Analysis
- Review Wazuh alert
- Correlate with Windows Event Logs
- Check network connections from Kali
- Identify affected systems

### 3. Containment
- Isolate affected VM (disable network)
- Take forensic snapshot
- Block attacker IP at host firewall

### 4. Eradication
- Remove malware/persistence
- Patch vulnerability
- Restore from clean snapshot if needed

### 5. Recovery
- Restore VM to production state
- Verify Wazuh agent connectivity
- Confirm no residual IOCs

### 6. Lessons Learned
- Document timeline
- Identify detection gaps
- Update playbooks
