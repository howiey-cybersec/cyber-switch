# Day 4 - Linux privilege & permission audit

> Goal: enumerate and harden local privilege boundaries.

## Actual Commands I ran (and why)

| `sudo cat /etc/passwd > outputs/passwd_snapshot.txt` | Saves user list snapshot. | Future diff would reveal rogue users. |
| `ls -l /etc/shadow > outputs/shadow_perms.txt` | Captures `shadow` file perms (`-rw-r-----`). | Confirms hashes readable only by root:shadow. |
| `sudo find / \\( -path /proc -o -path /sys \\) -prune -o -type f -perm -0002 -not -path '/tmp/*' -print` | Searches for **world-writable** files outside `/tmp`. | World-writable ≈ anyone can inject code. |
| `sudo find / -perm /6000 -type f` | Lists **SUID/SGID** binaries. | Unexpected SUID root files =  common priv-esc vectors. |
| `sudo -l` | Shows what my user can `sudo`. | Spots dangerous `NOPASSWD` or wildcards. |
| `visudo` edits | Removed `NOPASSWD`, added `Defaults timestamp_timeout=5`. | Forces password each time; short ticket window. |
| `scripts/perm_audit.sh` | Automated all of the above; ShellCheck-clean. | Turned manual checks into repeatable control. |
##  Glossary

| Term | Meaning |
|------|---------|
| **UID** – User ID; UID 0 ⇒ root. |
| **GID** – Group ID controlling group perms. |
| **SUID** – “Set User ID”; file runs with owner’s privilege (dangerous if owner = root). |
| **SGID** – “Set Group ID”; runs with file’s group privilege. |
| **NOPASSWD** – sudoers flag skipping password prompt. |
| **`find … -perm /6000`** – matches files with SUID **or** SGID bit set. |
| **ShellCheck** – lint tool that spots bugs/injections in Bash scripts. |
