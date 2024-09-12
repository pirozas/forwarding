#!/bin/bash

# Define variables
REPO_URL="https://github.com/pirozas/iptables-manager.git"
TEMP_DIR="/tmp/iptables-manager"

# Prompt for GitHub token if not already set
if [ -z "$GITHUB_TOKEN" ]; then
    read -p "Enter your  token: " GITHUB_TOKEN
    REPO_URL="https://$GITHUB_TOKEN@github.com/pirozas/iptables-manager.git"
fi

# Enable debugging
set -x

# Update package lists
echo "Updating package lists..."
sudo apt-get update -y || { echo "Failed to update package lists"; exit 1; }

# Install iptables
echo "Installing iptables..."
sudo apt-get install -y iptables || { echo "Failed to install iptables"; exit 1; }

# Clone the repository
echo "Cloning the repository..."
git clone "$REPO_URL" "$TEMP_DIR" || { echo "Failed to clone repository"; exit 1; }

# Move the ipmanager script to /usr/bin
echo "Moving ipmanager to /usr/bin..."
sudo mv "$TEMP_DIR/ipmanager" /usr/bin/ipmanager || { echo "Failed to move ipmanager to /usr/bin"; exit 1; }

# Clean up
rm -rf "$TEMP_DIR"

# Make the script executable
echo "Setting executable permissions..."
sudo chmod +x /usr/bin/ipmanager || { echo "Failed to set executable permissions"; exit 1; }

echo "ipmanager has been installed. You can now run it using 'ipmanager'."
