# Day 03 - First Packet-Capture Mini-Lab

> Goal: Prove I can record traffic without sudo, isolate key handshake packets, and explain why they're important.

## 1. What I actually did

| Step | Command / action | Output |

|------|------------------|--------|

1. Full Capture (60s) | `tshark -i eth0 -a duration:60 -w artifacts/raw_day03.pcap | 7234 packets
2. Mark 3 important packets in Wireshark | `tcp.flags.syn==1 && tcp.flags.ack==0` <br> `dns && udp` <br> `tls.handshake.type==1` | 3 blue rows |
3. Export marked only | Wireshark -> *Export Packet Dissections* -> 
4. Screenshot


## 2. Why these three packets matter

SYN -> First step of the **TCP 3-way handshake** (cleint -> server). Surge of SYNs = port scan. Confirms client initiated flow.
DNS -> Name-resolution query over UDP/53 -> tells you *which* domain a user or malware is contacting **before** encryption. DNS-tunnel exfil trips here.
TLS ClientHello -> First message of the **TLS** (formerly SSL) handshake. Carries **SNI** hostname and cipher list. Lets SOC fingerprint malware (JA3). Shows TLS version.

## 3. Acronym crash course

**TCP** Transmission Control Protocol | Reliabble, connection-based transport (web, SSH). |
**SYN** Synchronize | TCP flag that asks to start a connection.
**ACK** Acknowledgement | TCP flag that confirms receipt.
**DNS** Domain Name System | Internet "phone book" that maps names -> IPs.
**UDP** User Datagram Protocol | Lightweight, connection-less transport (DNS, VoIP).
**TLS** Transport Layer Security | Encryption protocol that secures HTTPS 
**SNI** Server Name Indication | Hostname inside TLS ClientHello (needed for virtual hosts).
**pcap /pcapng** Packet CAPture file | Binary format Wireshark/tshark write.


