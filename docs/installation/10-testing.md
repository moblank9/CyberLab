# Testing and Verification

## Network Connectivity

From each VM, verify:

```bash
# All VMs should reach each other
ping 10.10.10.10
ping 10.10.10.20
ping 10.10.10.30
ping 10.10.10.40
ping 10.10.10.50
ping 10.10.10.60
```

## Wazuh Agent Check

On the Wazuh server:

```bash
sudo /var/ossec/bin/agent_control -l
sudo /var/ossec/bin/agent_control -ic <agent_id>
```

## Kali Tools

```bash
nmap -sn 10.10.10.0/24
msfconsole --version
```

## Lab Health Check

Run the health check script:

```bash
./scripts/health-check.sh
```

## Internet Isolation

Verify that VMs cannot reach the internet when NAT is disabled:

```bash
ping 8.8.8.8  # Should fail
ping 1.1.1.1  # Should fail
```
