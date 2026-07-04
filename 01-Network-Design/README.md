# 01 — Network Design

## Objective
Design a segmented network that mirrors a small enterprise: separate zones
for internal users, public-facing services, and security monitoring, all
routed through a central firewall.

## Architecture
```
                 pfSense (Firewall/Gateway)
                                        │
           WAN (Internet/Host) ─────────┼───────────
                                        │
                    ┌───────────────────┼───────────────────┐
                    │                   │                   │
                 [ LAN ]             [ DMZ ]             [ SOC ]
             192.168.10.x        192.168.20.x        192.168.30.x
             (Trusted Users)    (Exposed Servers)   (Security Ops)
```

| Zone | Subnet | Purpose |
|---|---|---|
| Management | _TBD_ | VirtualBox host-only network for hypervisor admin |
| Internal LAN | 192.168.10.0/24 | Employee devices: Windows 10/11, Ubuntu, AD, File Server |
| DMZ | 192.168.20.0/24 | Public-facing/vulnerable services: Juice Shop, DVWA, Metasploitable |
| SOC | 192.168.30.0/24 | Monitoring only: Wazuh, Security Onion, TheHive, Velociraptor |

## Steps Performed
1. Defined IP scheme and VLAN/subnet boundaries above
2. Created VirtualBox internal networks for LAN, DMZ, and SOC
3. Created a host-only "Management" network for direct hypervisor access
4. Diagrammed topology (see `/Diagrams/network-architecture.png`)

## Commands Used
```bash
# This outputs detailed data for each host-only adapter, including its IP address, subnet mask, and DHCP server status.
VBoxManage list hostonlyifs 

# This lists all active internal networks and shows which virtual machines are currently attached to them.
VBoxManage list intnets 

# Set Adapter 1 to NAT (WAN)
VBoxManage modifyvm "pfSense" --nic1 nat

# Set Adapter 2 to Internal Network (LAN)
VBoxManage modifyvm "pfSense" --nic2 intnet --intnet2 "lan_net"

# Set Adapter 3 to Internal Network (DMZ)
VBoxManage modifyvm "pfSense" --nic3 intnet --intnet3 "dmz_net"

# Set Adapter 4 to Host-Only (SOC)
VBoxManage modifyvm "pfSense" --nic4 hostonly --hostonlyadapter4 "VirtualBox Host-Only Ethernet Adapter"

# Disable the VirtualBox DHCP server on the Host-Only adapter so it does not conflict with pfSense.
VBoxManage dhcpserver remove --ifname "VirtualBox Host-Only Ethernet Adapter"


```

## Findings
- This network design follows the security principle of least privilege and network segmentation. Grouping VMs into specific zones strictly controls what they can access and minimizes the impact of a breach.

- Zone Breakdowns1. WAN Zone (Internet Access)
Purpose: To simulates the public internet and provides external connectivity.
Design Decision: Configured as a NAT or Bridged network.
Why VMs land here: Only the external interface of pfSense firewall goes here. No lab VMs sit directly on the WAN. I tried to mirror real-world setups where a firewall shields the entire corporate infrastructure from public traffic.

- LAN Zone (192.168.10.0/24)
Purpose: To hosts internal, highly trusted corporate assets and simulated user endpoints.
Design Decision: Isolated via an Internal Network (intnet).
Why VMs land here: This is where I placed internal Domain Controllers (Active Directory), and internal file servers. These machines must never be able to reach the internet directly. They can initiate outbound connections to the internet (via pfSense) to download updates or simulate user web browsing, but outbound access to the DMZ and SOC is strictly limited.

- DMZ Zone (Demilitarized Zone | 192.168.20.0/24)
Purpose: To hosts public-facing services that must be accessible from the outside world.
Design Decision: Isolated via an Internal Network (intnet).
Why VMs land here: This zone houses vulnerable web servers, mail servers, or honeypots meant to be targeted. Because these servers are exposed, they are highly likely to be compromised. Placing them in a dedicated DMZ ensures that if an attacker compromises the web server, firewall rules will stop them from pivoting into the sensitive LAN or SOC zones.

- SOC Zone (Security Operations Centre | 192.168.30.0/24)
Purpose: To house management, monitoring, and defensive infrastructure.
Design Decision: Configured as a Host-Only Network.
Why VMs land here: This zone contains SIEM, IDS controllers, and malware analysis sandboxes.
Host-Only Choice: Using Host-Only allows the physical machine to connect directly to the SIEM web dashboards without exposing those dashboards to the insecure LAN or DMZ zones.
Security Isolation: VMs in the LAN and DMZ are configured to ship logs outbound to the SOC, but they are completely blocked from initiating any administrative or control connections into the SOC.

- Core Firewall Routing Logic
To make the design functional and secure, pfSense firewall rules enforce the following logic
-SOC can access LAN, DMZ, and WAN (Full administrative override).
-LAN can access WAN and specific services in the DMZ (e.g., HTTP/HTTPS), but cannot access the SOC.
-DMZ can access WAN (for updates), but is completely blocked from initiating connections to LAN and SOC

## Lessons Learned
When building a cyberlab, understanding how VirtualBox manages its network virtualization engine is critical. Minor configuration mistakes can break the isolation or cause silent traffic leaks.

- Architectural Pitfalls & Lessons Learned

1. The "Same Name" Illusion in Internal Networks (intnet)
The Mechanism: VirtualBox creates a virtual, isolated software switch for every unique string entered into the Internal Network name field.

The Pitfall: VirtualBox does not validate the names. When lan_net is typed on the pfSense interface, but accidentally type lan-net or lannet on a Windows client, VirtualBox creates a brand-new, independent virtual switch.

The Symptom: The client VM will fail to receive a DHCP lease from pfSense, or static IP routing will fail completely, despite looking correct at first.

Lesson: Enforce a strict naming convention. Always copy-paste network names or use lowercase alphanumeric characters without symbols.

2. Promiscuous Mode Traps during Packet Sniffing
The Mechanism: To capture traffic running through a virtual switch using an IDS like Snort or Suricata or Wireshark, the VM's network adapter must be allowed to read packets not explicitly addressed to it.

The Pitfall: By default, VirtualBox sets Promiscuous Mode to Deny on all interfaces. If you deploy an IDS network tap or a packet forwarder in the SOC zone, it will only capture broadcast traffic and traffic destined for its own MAC address.

Lesson: I must explicitly change this setting to Allow All or Allow VMs within the advanced dropdown of the network adapter settings for your monitoring interfaces.

3. Host-Only Adapter Subnet Conflicts
The Mechanism: A Host-Only network creates a loopback interface on your physical machine, allowing the host OS to communicate with the guest VMs.

The Pitfall: VirtualBox automatically manages its own internal DHCP server and subnet ranges for Host-Only adapters. If the physical home network or local Wi-Fi router happens to use the same subnet range as the cyberlab zones, routing tables on the host machine will conflict. This causes intermittent connectivity drops, or exposes the lab traffic to the actual home network.

Lesson: Explicitly define non-overlapping subnets for the lab. Disable the built-in VirtualBox DHCP engine on the host adapter entirely if pfSense is handling the assignments.

4. The MAC Address Cloning Oversight
The Mechanism: Hypervisors identify distinct virtual nodes on a switch via unique Media Access Control (MAC) addresses.

The Pitfall: When spinning up multiple client or server nodes rapidly, security analysts frequently clone a base VM template. By selecting a standard clone without checking the option to Generate new MAC addresses for all network adapters, multiple VMs will enter the lab switch with identical hardware addresses.

Symptom: MAC flapping on the virtual switch. Traffic will randomly route to one VM and then the other, breaking handshakes, dropping SSH connections, and ruining log aggregation consistency.

Lesson: Always check the box to re-initialize MAC addresses when deploying clones or importing OVA/OVF templates.
