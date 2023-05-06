#!/bin/bash

# This function checks if the operating system is verified, disk usage is more than 5GB free space, 
# public IP is assigned and the user is valid.

function verify_os_disk_ip_user() {
    # Verify the operating system
    if [ "$(uname)" != "Linux" ]; then
       echo "Error: This function only works on Linux operating systems."
        return 1
    fi
    
    # Check disk usage
    disk_usage=$(df -h / | awk '{print $4}' | tail -n 1)
    if [ ${disk_usage%?} -lt 5 ]; then
        echo "Error: Not enough disk space available."
        return 1
    fi
    
    # Check if public IP is assigned
    public_ip=$(curl -s ifconfig.me)
    if [ -z "$public_ip" ]; then
        echo "Error: Public IP not assigned."
        return 1
    fi
    
    # Check if user is valid
    if [ "$(whoami)" != "root" ]; then
        echo "Error: This function must be run as root."
        return 1
    fi
    
   echo  "$(uname)"
   echo  "$public_ip"
   echo  "$(df -h / | awk '{print $4}')"
   echo  "$(f -h / | awk 'NR==2{print $4}')"
   echo  "$(whoami)"
    echo "Verification successful."
    
    return 0
}
# Call the function
verify_os_disk_ip_user
