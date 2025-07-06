# Day 5 - nmap recon notes

today was just about getting comfortable with nmap, not crazy vuln-scans,
keeping it simple.

--- 

## what I actually did:

```bash
# 1) find who's alive on my NAT net
sudo nmap -sn 10.0.2.0/24 -oN outputs/host_discovery.txt

# 2) top-1k TCP SYN scan against my kali VM (10.0.2.15)
sudo nmap -sS --top-ports 1000 10.0.2.15 -oN outputs/tcp_top1k.txt

# 3) quick UDP sweep - top 100 ports
sudo nmap -sU --top-ports 100 10.0.2.15 -oN outputs/udp_top100.txt

## results (tl;dr)

- **host discovery:** only my box (`10.0.2.15`) + the NAT gateway popped.
- **tcp scan:** *zero* open ports in top-1000 → skipped `-sV`.
- **udp scan:**
  - `500/udp` → **isakmp** (IPsec/IKE) **open**
  - `4500/udp` → **nat-t-ike** **open | filtered**
  - the other 98 UDP ports returned *port-unreach* → closed

so the VM is basically just exposing an IPsec VPN endpoint over UDP.

---

## why it matters

- watched **SYN** behaviour we captured on Day 3 – now from the **scanner** side.
- practised `-sn`, `-sS`, `-sU`, CIDR (`10.0.2.0/24`).
- Security+ tie-in: ports **500** & **4500** are default IPsec (IKE + NAT-T) – good “memorise-the-port” trivia.

---

## next

tomorrow → point `-sV -sC` at a vuln VM (metasploitable) so I actually have banners to fingerprint.
