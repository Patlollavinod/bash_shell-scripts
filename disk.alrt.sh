#!/bin/bash

# Verify OS and version compatibility
os=$(lsb_release -d | awk -F"\t" '{print $2}')
if [ "$os" != "Ubuntu 22.04 LTS" ]; then
	  echo "Error: This script is only compatible with Ubuntu 20.04 LTS"
	    exit 1
fi

# Check disk space usage
space=$(df -h / | awk '{print $5}' | tail -n 1 | cut -d'%' -f1)
if [ "$space" -gt 5 ]; then
	  echo "Error: Disk space usage is over 5%"
	    exit 1
fi

# Check free space
freespace=$(df -h / | awk '{print $4}' | tail -n 1 | cut -d'G' -f1)
if [ $(echo "$freespace > 1" | bc) -eq 0 ]; then
	  echo "Error: Free space is less than 1GB"
	    exit 1
fi

# Check if public IP is assigned
ip=$(curl -s ifconfig.me)
if [ -z "$ip" ]; then
	  echo "Error: Public IP is not assigned"
	    exit 1
fi

# Check if user is valid
user=$(whoami)
if [ "$user" != "validuser" ]; then
	  echo "Error: User is not valid"
	    exit 1
fi

echo "All checks passed"

