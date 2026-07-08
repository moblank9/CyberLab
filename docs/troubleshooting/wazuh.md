# Wazuh Troubleshooting

## Agent not connecting

```bash
# On agent
sudo /var/ossec/bin/agent_control -l           # List agents
sudo /var/ossec/bin/manage_agents               # Manage agent keys
sudo tail -f /var/ossec/logs/ossec.log          # Watch agent log

# On server
sudo tail -f /var/ossec/logs/ossec.log
sudo systemctl status wazuh-manager
```

## Check agent status

```bash
sudo /var/ossec/bin/agent_control -l
# Active agents show status as "Active"
```

## Restart services

```bash
# Server
sudo systemctl restart wazuh-manager

# Agent
sudo systemctl restart wazuh-agent
```

## Web UI issues

- Verify Wazuh dashboard service: `sudo systemctl status wazuh-dashboard`
- Check port 443 is open: `sudo ss -tlnp | grep 443`
- Reset admin password: `sudo wazuh-passwords-tool -u admin -p <new-password>`
