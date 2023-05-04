#!/bin/bash

#####################################################################
# Author: vinod
# Version: v1.0.0
# Date: 25-Aug-2020
# Description: This script demonstrates  to know  os version,public ip ,free memory,disk space,user_app 
# Usage: ./pre-req.sh
#####################################################################
echo " check ubuntu "

sudo lsb_release -a # os verision
#sudo df -T 
#sudo df -h | grep '[[:digit:]]\+G' #disk space more than 5GB
sudo free   -g   #free space more than 1GB
sudo curl ifconfig.me #public ip assign or not
#sudo su - vpatlolla which nano # ubuntu user checking
sudo id vpatlolla #ubuntu user check
sudo  df -h | awk '$4+0 >= 5 {print}'
