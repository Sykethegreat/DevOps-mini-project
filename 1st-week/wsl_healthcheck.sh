#!/bin/bash

# Ensure logs directory exists
mkdir -p "$(dirname "$0")/../logs"

# Create timestamped log file
timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
log_file="$(dirname "$0")/../logs/wsl_healthcheck_${timestamp}.log"

#Begin report
{
echo "========================================="
echo "SYSYTEM HEALTH REPORT"
echo "DATE: $(date)"
echo "========================================="

echo -e "\n UPTIME:"
uptime -p

echo -e "\n CPU LOAD:"
uptime | awk -F'load average:' '{ print "Load Average:" $2 }'

echo -e "\n MEMORY USAGE:"
free -h

echo -e "\n DISK USAGE (SUMMARY):"
df -h --total | tail -n 1

echo -e "\n TOP 3 CPU-CONSUMING PROCESSES:"
ps -eo pid,ppid,cmd,%cpu,%mem --sort=%cpu | head -n 4

echo -e "\n NETWORK CONNECTIVITY:"
ping -c 2 8.8.8.8 >/dev/null 2>&1 && echo "Network OK" || echo "Network DOWN"

echo -e "\n ========HEALTH REPORT COMPLETED========"
echo "Log file saved to: $log_file" 
} | tee "$log_file"
