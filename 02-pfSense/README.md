# 02 — pfSense Firewall

## Objective
Deploy pfSense as the central firewall/router for the lab, with interfaces
for WAN, LAN, DMZ, and SOC, and configure routing, DHCP, DNS, NAT, and
firewall rules between zones.

## Architecture
- pfSense VM with 4 virtual NICs: WAN, LAN, DMZ, SOC
- DHCP scopes per internal interface
- NAT for outbound internet access from each zone
- Inter-VLAN firewall rules enforcing least privilege (e.g. DMZ cannot
  initiate connections to SOC or LAN)

## Steps Performed
1. Installed pfSense from ISO into a dedicated VM
2. Assigned interfaces (WAN/LAN/DMZ/SOC) to the corresponding virtual NICs
3. Configured DHCP server per internal interface
4. Configured outbound NAT rules
5. Wrote firewall rules:
   - Allow LAN → Internet
   - Allow DMZ → Internet (restricted)
   - Deny DMZ → LAN
   - Deny DMZ → SOC
   - Allow LAN/DMZ → SOC on Wazuh agent ports only (1514/1515)

## Commands Used
```
# pfSense is configured primarily via its web UI (https://<pfsense-ip>)

# Config backups can be exported via Diagnostics > Backup & Restore

# Interface Assignment & IPs 
Because the virtual machine has 4 NICs, assign them using the primary console or hypervisor.
Console or SSH Option 1: 1) Assign Interfaces to map WAN, LAN, DMZ, and SOC to the correct hardware ports.
Console or SSH Option 2: 2) Set interface IP addressess to give static IPs to the LAN, DMZ, and SOC networks

# DHCP Servers 
Navigate to Services > DHCP Server.
Select the desired tab, LAN, DMZ, or SOC.
Check Enable DHCP server on interface, define the Range (, 192.168.10.100 to 192.168.10.200), and specify DNS servers

# Outbound NAT Rules 
Navigate to Firewall > NAT > Outbound.
Select Hybrid Outbound NAT rule generation and click Save.
Add rules to map your local subnets to the WAN address so all zones can access the internet.

# Inter-VLAN Firewall Rules
Navigate to Firewall > Rules and apply these to their respective tabs. Be mindful of rule ordering (rules are evaluated top-to-bottom on first match).
1. Allow LAN → Internet
Tab: LAN
Action: Pass
Source: LAN net
Destination: any
2. Allow DMZ → Internet (Restricted)
Tab: DMZ
Action: Pass
Source: DMZ net
Destination: any

Note: To restrict this, you can create a DNS pass-rule first, followed by a block rule for local subnets, and then a pass rule for Internet.

3. Deny DMZ → LAN
Tab: DMZ
Action: Block
Source: DMZ net
Destination: LAN net
4. Deny DMZ → SOC
Tab: DMZ
Action: Block
Source: DMZ net
Destination: SOC net
5. Allow LAN/DMZ → SOC on Wazuh agent ports (1514/1515)
Tab: LAN (and DMZ)
Action: Pass
Source: any (or LAN net/DMZ net)
Destination: SOC net
Destination Port Range: Create or use an alias with ports 1514 and 1515 (TCP).
```

## Findings
- No Internet Access in LAN or DMZ zones. Missing or incorrectly scoped Outbound NAT rules; DNS misconfiguration. Confirm Outbound NAT is set to Hybrid/Manual. Ensure clients receive the correct DNS IP via DHCP.

- DMZ → LAN block rule isn't working. Rule evaluation order; permissive rules overriding the block. Move the Block DMZ → LAN rule to the top of the DMZ ruleset. (Remember: rules are evaluated top-to-bottom).

- Wazuh agents failing to connect to SOC. Stateful blocking or missing UDP/TCP rule configurations. Ensure the Allow LAN/DMZ → SOC rule explicitly targets TCP for ports. Do not use Any protocol.

- DMZ has full Internet access instead of restricted access. Default allow all rule at the bottom of the DMZ tab. Replace the generic Allow DMZ → Internet rule with specific rules: 1) Pass DNS, 2) Block local subnets (! DMZ net), 3) Pass all other (Internet) destinations.

- Lab machines getting incorrect IPs / no IPs. Misconfigured DHCP scopes; multiple DHCP servers. Check Services > DHCP Server. Ensure the correct virtual adapters are attached in the hypervisor.

- Default Deny: While "allow all" rule initially is used to test connectivity, it would be best to start with a "deny all" default policy and explicitly allow only required traffic.

- Logging Block Rules: Enable logging (Log packets that are handled by this rule) on the block rules to help identify if legitimate traffic is inadvertently being dropped.

- Aliases: Utilize pfSense Aliases to group subnets and port numbers to make the ruleset much easier to read and maintain.

## Lessons Learned
- Boot-time mismatch: pfSense links logical interfaces (WAN, LAN) to physical/virtual MAC addresses (vtnet0, vtnet1) in a specific boot order. Adding or deleting a virtual NIC in your hypervisor changes this order. Your DMZ could easily become your WAN on the next reboot.

- WebGUI lockout: If the hypervisor reorders your interfaces, the default "Anti-Lockout Rule" stays tied to the logical "LAN" interface. If LAN moves to an isolated virtual switch, you lose HTTPS access to the firewall.

- Rule migration failure: Rules are tied to the interface name. If you delete an interface to re-order them, pfSense purges all firewall rules assigned to that interface tab without warning.

- DHCP binding loops: If virtual NICs are assigned to the wrong VLANs or vSwitches during setup, the DHCP server will broadcast scopes into the wrong zones. A DMZ asset might accidentally receive a high-privileged LAN IP.

- Packet capture confusion: Troubleshooting with tcpdump or the Packet Capture tool requires knowing the raw interface name (vtnet2, em2). These do not mirror your custom names ("SOC", "DMZ"), leading to capturing data on the wrong network segment.

- The Hairpin loop: NAT reflection allows internal LAN/DMZ clients to connect to an internal server using its external public WAN IP. Without it, typing your public IP or external domain name from inside the lab will result in a connection timeout.

- Pure NAT mode limitations: Selecting "Pure NAT" mode utilizes system routing to mirror the connection. However, it completely fails for any TCP/UDP ports outside the standard 1–1024 range unless explicitly configured.

- NAT + Proxy resource drain: Using "NAT + Proxy" mode creates a separate helper program for each connection. In a busy lab environment or during vulnerability scanning, this quickly exhausts firewall states and crashes the web service.

- Source IP masking: When using NAT reflection, the target server sees all incoming internal traffic as originating from the pfSense interface IP, not the actual client IP. This completely breaks security logging and SIEM tracking for internal attacks.

- Split-Horizon DNS alternative: Relying on NAT reflection is generally considered a crutch. The industry-standard fix is configuring Split-Horizon DNS in Services > DNS Resolver, forcing internal clients to resolve the domain directly to the local private IP.


> ⚠️ Do not commit pfSense XML config backups containing real secrets/hashes.
> See repo `.gitignore`. If you want to share a config, strip credentials
> first and save it as `*-example.xml`.
