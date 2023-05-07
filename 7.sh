#!/bin/bash

# Function to verify OS and OS version
os_verify() {
    # Check if OS is Ubuntu
    if [[ "$(cat /etc/os-release | grep -w ID | cut -d'=' -f2)" == "ubuntu" ]]; then
        echo "Ubuntu OS detected"
    else
        echo "Unsupported OS detected"
        exit 1
    fi

    # Check OS version
    os_version=$(lsb_release -r | awk '{print $2}')
    if [[ "$os_version" == "18.04" || "$os_version" == "20.04" || "$os_version" == "22.04" ]]; then
        echo "Supported OS version detected"
    else
        echo "Unsupported OS version detected"
        exit 1
    fi
}

# Function to check if public IP is assigned
public_ip_check() {
    # Get public IP address
    public_ip=$(curl -s ifconfig.me)

    # Check if public IP is assigned
    if [[ -z "$public_ip" ]]; then
        echo "Public IP not assigned"
        exit 1
    else
        echo "Public IP assigned: $public_ip"
    fi
}

# Function to check disk usage and free space
disk_space_check() {
    # Get disk usage and free space
    disk_usage=$(df -h / | awk '{print $5}' | tail -1 | sed 's/%//')
    free_space=$(df -h / | awk '{print $4}' | tail -1 | sed 's/G//')

    # Check if disk usage is more than 5GB and free space is more than 1GB
    if [[ "$disk_usage" -gt 80 ]]; then
        echo "Disk usage is more than 80%"
        exit 1
    elif [[ "$free_space" -lt 1 ]]; then
        echo "Free space is less than 1GB"
        exit 1
    else
        echo "Disk usage: $disk_usage%"
        echo "Free space: $free_space GB"
    fi
}

# Function to check if user is valid
user_valid_check() {
    # Get current user
    current_user=$(whoami)

    # Check if user is valid
    if [[ "$current_user" == "root" ]]; then
        echo "Valid user detected"
    else
        echo "Invalid user detected"
        exit 1
    fi
}

# Call functions
os_verify
public_ip_check
disk_space_check
user_valid_check
