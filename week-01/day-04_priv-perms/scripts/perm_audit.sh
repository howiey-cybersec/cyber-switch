#!/usr/bin/env bash
set -u   # e = exit on error; u = undefined var error

echo "[*] World-writable files outside /tmp (skipping /proc & /sys):"
sudo find / \( -path /proc -o -path /sys \) -prune -o \
     -type f -perm -0002 -not -path '/tmp/*' -print 2>/dev/null

echo -e "\n[*] Files with SUID/SGID bit:"
sudo find / -perm /6000 -type f 2>/dev/null

echo -e "\n[*] Users with UID 0 (root equivalents):"
awk -F: '$3==0{print $1}' /etc/passwd
