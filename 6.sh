#!/bin/bash

# This function checks if the disk usage is more than 5GB and free space is more than 1GB

function check_disk_space {
    # Get the disk usage in GB
    disk_usage=$(df -h / | awk 'NR==2{print $3}' | sed 's/G//')
    # Get the free space in GB
    free_space=$(df -h / | awk 'NR==2{print $4}' | sed 's/G//')
    
    # Check if disk usage is more than 5GB and free space is more than 1GB
    if (( $(echo "$disk_usage > 5" | bc -l) )) && (( $(echo "$free_space > 1" | bc -l) )); then
        echo "Disk usage is more than 5GB and free space is more than 1GB"
    else
        echo "Disk usage is less than or equal to 5GB or free space is less than or equal to 1GB"
    fi
}
echo "$(df -h / | awk 'NR==2{print $4}')"
echo "$(df -h / | awk 'NR==2{print $3}')"

# Call the function
check_disk_space
