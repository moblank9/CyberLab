# Windows 10 Troubleshooting

## Remote Desktop not working

- Enable RDP: System Properties → Remote → Allow Remote Connections
- Check firewall: `netsh advfirewall firewall set rule group="remote desktop" new enable=Yes`
- Verify network profile is Private

## Wazuh agent not connecting

- Check agent service is running: `services.msc` → Wazuh
- Verify agent config: `C:\Program Files (x86)\ossec-agent\ossec.conf`
- Check connectivity: `telnet 10.10.10.10 1514`

## Network issues

- Verify IP config: `ipconfig /all`
- Check adapter is Internal Network, not NAT
- Disable Windows Firewall for lab use

## Guest Additions issues

- Reinstall from VM menu: Devices → Insert Guest Additions CD
- Run installer as Administrator
- Reboot after installation
