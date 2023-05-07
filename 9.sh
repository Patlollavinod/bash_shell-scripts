#!/bin/bash

# Function to verify OS and version
function os_verify() {
    # Check if OS is Ubuntu
    if [[ "$(uname -a)" == *"Ubuntu"* ]]; then
        # Check Ubuntu version
        version=$(lsb_release -r | awk '{print $2}')
        echo "$(lsb_release -r)"
        echo "Ubuntu $(lsb_release -r) detected"
    else
        echo "Unsupported OS"
    fi
}

# Function to check if public IP is assigned
function public_ip_assigned() {
    # Get public IP address
    ip=$(curl -s https://api.ipify.org)
    if [[ -z "$ip" ]]; then
        echo "Public IP not assigned"
    else
        echo "Public IP assigned: $ip"
    fi
}

# Function to check disk space
function check_disk_space() {
    # Get disk space in GB
    disk_space=$(df -h / | awk 'NR==2{print $4}' | sed 's/G//')
    if (( $(echo "$disk_space > 5" | bc -l) )); then
        echo "Disk space: $disk_space GB"
    else
        echo "Insufficient disk space"
    fi
}

# Function to check free space
function check_free_space() {
    # Get free space in GB
    free_space=$(df -h / | awk 'NR==2{print $3}' | sed 's/G//')
    if (( $(echo "$free_space > 1" | bc -l) )); then
        echo "Free space: $free_space GB"
    else
        echo "Insufficient free space"
    fi
}

# Function to check if user is valid
function check_user_valid() {
    # Get current user
    user=$(whoami)
    if [[ "$user" == "root" ]]; then
        echo "Valid user: $user"
    else
        echo "Invalid user: $user"
    fi
}

# Call functions
os_verify
public_ip_assigned
check_disk_space
check_free_space
check_user_valid
