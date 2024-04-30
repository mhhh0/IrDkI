#!/bin/bash
# Script to install Docker from a GitHub Gist

# WARNING: Running scripts from the Internet as root can be hazardous. Please inspect the script before running it.
# To run this script, login as root via SSH and run the following command:
# bash <(curl -Ls https://raw.githubusercontent.com/mhhh0/IrDkI/main/IrDockerInstaller.sh)

# Define the URL of the Gist containing the Docker installation script
GIST_URL="https://raw.githubusercontent.com/mhhh0/IrDkI/main/IrDockerInstaller.sh"

# Download the Docker installation script from the GitHub Gist
curl -L $GIST_URL -o install_docker.sh

# Check if the download was successful
if [ -f "install_docker.sh" ]; then
    echo "Downloaded the Docker installation script successfully."

    # Make the script executable
    chmod +x install_docker.sh

    # Run the Docker installation script
    sudo ./install_docker.sh

    # Optional: Clean up by removing the script after installation
    rm install_docker.sh

    echo "Docker has been installed successfully."
else
    echo "Failed to download the Docker installation script. Please check the Gist URL."
fi
