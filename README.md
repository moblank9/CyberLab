# Enterprise Styled Cybersecurity Home Lab

This repository documents the construction of a self-built "cyber range" simulating an enterprise network — used to practice penetration testing, system administration, SIEM detection engineering, and threat hunting in a fully isolated, segmented environment.

The goal of this project is to simulate real-world cyber attacks and analyze how a SOC environment detects and responds to them.

## Architecture

![Network Diagram](Diagrams/network-architecture.png)

```
                           Home Network
                               │
                     Ubuntu Host (Laptop 1)
                               │
                      VirtualBox Hypervisor
                               │
                       Management Network
                               │
                        pfSense Firewall
                               │
         ┌───────────────┬───────────────┬───────────────┐
         │               │               │
      DMZ Network     Internal LAN    SOC Network
   192.168.20.x      192.168.10.x    192.168.30.x
```

- **pfSense** firewall segments traffic between three zones
- **Internal LAN** (192.168.10.x) — Windows 10/11, Ubuntu, Active Directory, File Server
- **DMZ** (192.168.20.x) — OWASP Juice Shop, DVWA, Metasploitable
- **SOC Network** (192.168.30.x) — Wazuh SIEM, TheHive, Velociraptor

Attack traffic only ever flows into the DMZ. The SOC network is monitoring-only
and should never originate offensive traffic — this should mirror how real
organizations isolate detection infrastructure from production systems.

## Tech Stack

| Category                      | Tools                                                       |
|-------------------------------|-------------------------------------------------------------|
| Virtualization                | VirtualBox                                                  |
| Firewall / Networking         | pfSense                                                     |
| Identity                      | Active Directory, Group Policy                              |
| SIEM                          | Wazuh, Elastic / OpenSearch                                 |
| Offensive Security            | Kali, Nmap, Gobuster, Hydra, Burp Suite, Metasploit, Netcat |
| Incident Response / Forensics | TheHive, Velociraptor                                       |
| Automation                    | Python, Bash                                                |
| Vulnerable Targets            | OWASP Juice Shop, DVWA, Metasploitable                      |

## Hardware Layout

| Host     | OS                 | Role                                                        |
|----------|--------------------|-------------------------------------------------------------|
| Laptop 1 | Ubuntu Desktop LTS | Main workstation, VirtualBox host, pentesting, dev          |
| Laptop 2 | Ubuntu Server LTS  | Dedicated SOC — Wazuh, Security Onion, TheHive, Velociraptor|

## Repository Structure

| Folder                                               | Contents                                               |
|------------------------------------------------------|--------------------------------------------------------|
| [`01-Network-Design/`](01-Network-Design/)           | Topology, IP scheme, segmentation rationale            |
| [`02-pfSense/`](02-pfSense/)                         | Firewall rules, NAT, DHCP/DNS configs                  |
| [`03-Active-Directory/`](03-Active-Directory/)       | Domain setup, OUs, GPOs                                |
| [`04-Windows-Hardening/`](04-Windows-Hardening/)     | CIS benchmarks applied, before/after                   |
| [`05-Linux-Hardening/`](05-Linux-Hardening/)         | SSH hardening, auditd, fail2ban                        |
| [`06-Wazuh/`](06-Wazuh/)                             | SIEM deployment, agent configs, custom detection rules |
| [`07-Threat-Hunting/`](07-Threat-Hunting/)           | Investigation writeups, IOC hunts                      |
| [`08-Penetration-Testing/`](08-Penetration-Testing/) | Attack chains, screenshots, findings                   |
| [`09-Malware-Analysis/`](09-Malware-Analysis/)       | Sandboxed sample teardown notes                        |
| [`10-Automation/`](10-Automation/)                   | Python/Bash scripts for provisioning, log parsing, reporting |
| [`Diagrams/`](Diagrams/)                             | Network and architecture diagrams                      |
| [`Screenshots/`](Screenshots/)                       | Supporting screenshots referenced in writeups          |
| [`Reports/`](Reports/)                               | Polished writeups / incident reports                   |

## Project Goals

Built to develop hands-on skill in:
- Network segmentation and firewall administration
- Active Directory deployment and hardening
- SIEM detection rule authoring
- Offensive security techniques and their corresponding blue-team detections
- Scripting for security automation

## Build Phases

- [x] Phase 1 — Foundation (host setup, VirtualBox, networks)
- [ ] Phase 2 — Firewall (pfSense)
- [ ] Phase 3 — Active Directory
- [ ] Phase 4 — Linux Infrastructure
- [ ] Phase 5 — SIEM (Wazuh)
- [ ] Phase 6 — Offensive Security
- [ ] Phase 7 — Detection Engineering
- [ ] Phase 8 — Threat Hunting
- [ ] Phase 9 — Automation
- [ ] Phase 10 — Documentation Polish

## Sample Findings

_Links to standout write-ups will go here as they're completed, e.g.:_
- [Detecting Brute-Force RDP Attempts with Wazuh](Reports/)
- [SQL Injection to Domain Compromise — Full Attack Chain](Reports/)

## Disclaimer

This lab is fully isolated and air-gapped from production networks. All
testing is performed against intentionally vulnerable systems I own and
control (OWASP Juice Shop, DVWA, Metasploitable). No techniques here are
used against systems without explicit authorization.
