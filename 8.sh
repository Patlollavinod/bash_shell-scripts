 #!/bin/bash

function system_check() {
    # Check OS version
    os_version=$(cat /etc/os-release | grep -w "VERSION_ID" | cut -d '"' -f 2)
    if [[ $os_version -eq "20.04" ]]; then
        echo "OS version is Ubuntu 20.04"
    else
        echo "OS version is not Ubuntu 20.04"
    fi

    # Check if public IP is assigned
    public_ip=$(curl -s ifconfig.me)
    if [[ -z $public_ip ]]; then
        echo "Public IP is not assigned"
    else
        echo "Public IP is $public_ip"
    fi

    # Check disk space
    disk_space=$(df -h / | awk '{print $4}' | tail -n 1 | sed 's/G//')
    if [[ $disk_space -ge 5 ]]; then
        echo "Disk space is greater than or equal to 5GB"
    else
        echo "Disk space is less than 5GB"
    fi

    # Check free space
    free_space=$(df -h / | awk '{print $4}' | tail -n 1 | sed 's/G//')
    if [[ $free_space -ge 1 ]]; then
        echo "Free space is greater than or equal to 1GB"
    else
        echo "Free space is less than 1GB"
    fi

    # Check user validity
    if [[ $(id -u) -eq 0 ]]; then
        echo "User is valid"
    else
        echo "User is not valid"
    fi
}

# Call the function
system_check
