# Network Isolation

## Principles

1. The lab network (10.10.10.0/24) MUST NOT have routes to the home network
2. No VM has internet access by default
3. NAT is only enabled on specific VMs during maintenance windows
4. Only one VM at a time may have NAT enabled

## Enforcement

- VirtualBox Internal Network provides hardware-level isolation
- Host firewall drops all forwarded traffic between vboxnet0 and physical NICs
- No bridge mode is used for lab VMs

## Verification

```bash
# From host — verify no forwarding
sudo iptables -L FORWARD -v

# From VM — verify no internet
ping 8.8.8.8
```
