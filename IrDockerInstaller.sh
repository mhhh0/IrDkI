#!/bin/bash
# Script to install Docker from a GitHub Gist

# WARNING: Running scripts from the Internet as root can be hazardous. Please inspect the script before running it.
# This script downloads and installs Docker using a script hosted on GitHub.
# To run this script, login as root via SSH and run the following command:
# bash <(curl -Ls https://raw.githubusercontent.com/mhhh0/IrDkI/main/IrDockerInstaller.sh)

# Define the URL of the Gist containing the Docker installation script
GIST_URL="https://raw.githubusercontent.com/mhhh0/IrDkI/main/IrDockerInstaller.sh"

# Function to handle exits with an error message and status
exit_with_error() {
    echo "$1" >&2
    echo "$2" >&2
    exit "${3:-1}"
}

# Check for existing Docker installation
if command -v docker &> /dev/null; then
    exit_with_error "Docker is already installed." "Please check the Docker version with 'docker --version' and ensure it meets your requirements." 0
fi

# Function to download the Docker installation script
download_script() {
    echo "Attempting to download the Docker installation script from $GIST_URL..."
    curl -L $GIST_URL -o install_docker.sh || exit_with_error "Error: Failed to download the Docker installation script." "Check your network connection or the status of the GitHub Gist URL." 1
}

# Function to run the installation script
run_installation() {
    if [ -s "install_docker.sh" ]; then
        echo "Downloaded the Docker installation script successfully."
        chmod +x install_docker.sh
        echo "Running the Docker installation script..."
        if sudo ./install_docker.sh; then
            echo "Docker has been installed successfully."
        else
            exit_with_error "Error: Docker installation failed." "Check the installation script for errors or incompatible settings with your system." 1
        fi
    else
        exit_with_error "Failed to download the Docker installation script." "The script might be empty or corrupted. Please verify the Gist URL and try again." 1
    fi
}

# Main script execution
download_script
run_installation

# Clean up the installation script
rm -f install_docker.sh
