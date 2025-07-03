<!-- day-02_networking/README.md -->

# Day 02 – Networking Basics
![workflow status](https://github.com/howiey-cybersec/cyber-switch/actions/workflows/lint.yml/badge.svg)
![last commit](https://img.shields.io/github/last-commit/howiey-cybersec/cyber-switch?style=flat)

> Key skills: OSI vs TCP/IP, packet capture, core CLI tools  

---

## 📊 Layer Models (Mermaid)

```mermaid 
graph TD
    subgraph OSI Model
        A7[Application Layer]
        A6[Presentation Layer]
        A5[Session Layer]
        A4[Transport Layer]
        A3[Network Layer]
        A2[Data Link Layer]
        A1[Physical Layer]
    end
    subgraph TCP/IP Suite
        A4[Application Layer]
        A3[Transport Layer]
        A2[Internet Layer]
        A1[Network Access Layer]