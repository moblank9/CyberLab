# Lateral Movement Playbook

## Objective
Simulate lateral movement across the lab network and detect via Wazuh.

## Scenario
Attacker gains access to Ubuntu Server 1 and moves to Windows 10.

## Steps

1. **Initial Access**
   - Exploit vulnerability on Ubuntu Server 1 (10.10.10.20)
   - Gain shell access from Kali (10.10.10.40)

2. **Lateral Movement**
   - Enumerate network (SMB, RDP, WinRM)
   - Attempt credential dumping
   - Move to Windows 10 target (10.10.10.30) using stolen credentials

3. **Detection**
   - Wazuh alerts on:
     - Failed login attempts
     - Unusual SMB connections
     - New service creation
     - Scheduled task creation

4. **Documentation**
   - Record techniques used
   - Map to MITRE ATT&CK (T1021, T1078, T1003)

5. **Cleanup**
   - Restore all VMs to baseline
