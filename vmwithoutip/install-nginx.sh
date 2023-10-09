#!/bin/bash

# Update the package list to get the latest updates
sudo apt update -y

sudo apt upgrade -y

# Install Nginx
sudo apt install -y nginx

# Start Nginx
sudo systemctl start nginx

# Enable Nginx to start at boot
sudo systemctl enable nginx
