# CyberLab
This is the start of a cybersecurity portfolio on GitHub, I created a documentation structure that demonstrates planning, architecture, security considerations, and operational procedures.

# Cybersecurity Home Lab Portfolio

## Overview

This repository documents the design, implementation, and operation of a personal cybersecurity laboratory built using Oracle VirtualBox.

The purpose of this lab is to develop hands-on cybersecurity skills in:

- Security Monitoring
- Threat Detection
- Vulnerability Assessment
- Incident Response
- Digital Forensics
- Network Security
- Ethical Hacking
- Security Operations (SOC)

The environment is completely isolated from the host operating system and external networks, providing a safe platform for security experimentation and attack simulations.

## Hardware Specifications

| Component | Specification |
|------------|--------------|
| CPU | Intel Core i5 6th Generation |
| RAM | 16GB DDR4 |
| Virtualization | Oracle VirtualBox |
| Storage | SSD Recommended |
| Host OS | Windows 10/11 |

## Virtual Machines

### Kali Linux
Purpose:
- Penetration Testing
- Vulnerability Assessment
- Attack Simulation

### Windows
Purpose:
- Attack Target
- Log Collection
- Security Monitoring

### Ubuntu Server
Purpose:
- Linux Target System
- Service Hosting
- Log Generation

### Wazuh Server
Purpose:
- SIEM Platform
- Log Aggregation
- Security Monitoring
- Alert Management

## Network Design

The lab uses an isolated VirtualBox Internal Network.

No internet access is available once the environment is deployed.

The host operating system cannot directly communicate with lab systems.

## Learning Objectives

- Build a Security Operations Center (SOC) lab
- Configure Wazuh SIEM
- Detect brute-force attacks
- Perform vulnerability scans
- Investigate security alerts
- Create professional cybersecurity documentation
