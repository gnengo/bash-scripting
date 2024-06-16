#!/bin/bash

### This script prints system info ###
echo "Welcome to bash script."

echo
# Checking system uptime
echo "#######################################"
echo "The uptime of the system is:"
uptime
echo

#Memory utilization
echo "######################################"
echo "Memory utilization:"
free -m
echo

echo "#####################################"
echo "Disk utilization:"
df -h
