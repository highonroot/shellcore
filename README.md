# Shellcore

Shellcore is a lightweight shell-based toolkit that combines multiple system 
utilities into a single command interface.

It serves as a central interface for common system tasks such as process management, network checks, file cleanup, and permission inspection.


## Features

- Unified command interface
- Interactive system utilities
- Process monitoring and termination
- Network diagnostics (DNS, ping, HTTP status)
- File permission inspection
- Directory and file analysis
- Cleanup utilities

---

## Installation

```bash
git clone https://github.com/highonroot/shellcore.git
cd shellcore
chmod +x shellcore
```

---

## Usage
```bash
./shellcore <command>
```

---

## Commands
### netprobe
Checks URL status, DNS resolution, ping reachability, and response time.
```bash
./shellcore netprobe <url>
```
### process
Displays running processes and allows you to terminate them interactively.
```bash
./shellcore process
```
### perm
Shows detailed file permissions (owner, group, others).
```bash
./shellcore perm <file>
```
### cleanup
Removes files by extension from a specified directory.
```bash
./shellcore cleanup <path>
```
### info
Displays detailed information about a file or directory.
```bash
./shellcore info <path>
```
### sysinfo
Displays system-level information.
```bash
./shellcore sysinfo
```
---

## Notes:
- Some commands are interactive and will prompt for additional input
- Run all commands from the root of the repository
- Ensure execution permissions are set with chmod +x shellcore

---

## Project Structure:
```bash
shellcore/
├── shellcore        # Main command router
├── commands/        # Individual utility scripts
└── README.md
```

---

## Purpose:
This project demonstrates practical shell scripting skills by building a
unified toolkit from scratch, focusing on real-world system operations
and command-line workflows.
