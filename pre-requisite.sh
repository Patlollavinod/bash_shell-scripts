#!/bin/bash

# This function checks if the operating system is verified, disk usage is more than 5GB free space, 
# public IP is assigned and the user is valid.
    # Verify the operating system
    if [ "$(uname)" != "Linux" ]; then
        echo "Error: This function only works on Linux operating systems."
        echo "$uname"
        return 1
    fi
    
    # Check disk usage
    disk_usage=$(df -h / | awk '{print $4}' | tail -n 1)
    if [ ${disk_usage%?} -lt 5 ]; then
        echo "Error: Not enough disk space available."
        echo "$disk_usage"
        return 1
    fi
    
    # Check if public IP is assigned
    public_ip=$(curl -s ifconfig.me)
    if [ -z "$public_ip" ]; then
        echo "Error: Public IP not assigned."
        echo "$pubilc_ip"
        return 1
    fi
    
    # Check if user is valid
    if [ "$(whoami)" != "root" ]; then
        echo "Error: This function must be run as root."
        echo "$whoami"
        return 1
    fi    
    echo "Verification successful."
    return 0

# Call the function
verify_os_disk_ip_user
