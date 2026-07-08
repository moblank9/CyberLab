# Phishing Playbook

## Objective
Simulate a phishing attack and detect it via Wazuh.

## Setup
- Set up a simple phishing server on Kali
- Target: Windows 10 user (10.10.10.30)

## Steps

1. **Preparation**
   - Create phishing page on Kali
   - Configure Wazuh to detect phishing indicators

2. **Execution**
   - Send phishing email (within lab network)
   - Target user clicks link and enters credentials

3. **Detection**
   - Monitor Wazuh for:
     - Unusual process execution
     - Network connections to Kali
     - Credential harvesting behavior

4. **Incident Response**
   - Isolate affected VM
   - Review logs
   - Change credentials
   - Document findings

5. **Cleanup**
   - Restore snapshots
   - Remove phishing server
