#!/bin/bash

# Colors
RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;33m"
NC="\033[0m"

echo -e "${YELLOW}==== System Monitor ====${NC}"

# Timestamp
echo "Started Monitoring at: $(date)"
echo ""

# CPU 
echo -e "${GREEN}Top CPU Processes:${NC}"
ps aux --sort=-%cpu | head -n 5

echo ""

# MEMORY
echo -e "${GREEN}Memory Usage:${NC}"
free -h

echo ""

# DISK
echo -e "${GREEN}Disk Usage:${NC}"
df -h

echo ""

# WARNING SYSTEM 
disk_usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$disk_usage" -gt 80 ]; then
    echo -e "${RED} Warning: Disk usage is above 80%"
    echo -e "Disk Usage: $disk_usage ${NC}"
else
    echo -e "${GREEN}Disk usage is normal${NC}"
fi
