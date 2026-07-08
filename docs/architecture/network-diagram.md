# Network Diagram

```
                    ┌───────────────────┐
                    │    Ubuntu Host     │
                    │  (Laptop 1 & 2)   │
                    └────────┬──────────┘
                             │
                    VirtualBox Internal
                    Network (10.10.10.0/24)
                             │
        ┌────────────────────┼────────────────────┐
        │                    │                    │
   Laptop 1             Laptop 2             Internet
   (Hypervisor)         (Worker)             (NAT, VMs only
        │                    │               when explicitly
        │                    │               enabled)
        └────────┬───────────┘
                 │
    ┌────────────┴──────────────┐
    │      Internal Switch      │
    │     (VirtualBox vboxnet)  │
    └────┬──────┬──────┬──────┬─┘
         │      │      │      │
    ┌────┴┐ ┌───┴┐ ┌──┴┐ ┌──┴┐
    │Wazuh│ │Ub  │ │Win│ │Kali│
    │ .10 │ │.20 │ │.30│ │.40│
    └─────┘ └────┘ └───┘ └───┘
```

## Network Types

| Network | Type | Purpose |
|---------|------|---------|
| 10.10.10.0/24 | Internal (vboxnet0) | All lab VM communication |
| 10.0.2.0/24 | NAT (vboxnet1) | Temporary internet access for updates |
