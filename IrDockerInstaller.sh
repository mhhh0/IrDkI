#!/usr/bin/env bash
# Script to install Docker from a GitHub Gist

# WARNING: Running scripts from the Internet as root can be hazardous. Please inspect the script before running it.
# To run this script, login as root via SSH and run the following command:
# sudo bash <(curl -Ls https://raw.githubusercontent.com/mhhh0/IrDkI/main/IrDockerInstaller.sh)

# Define the URL of the Gist containing the Docker installation script
GIST_URL="https://raw.githubusercontent.com/mhhh0/IrDkI/main/IrDockerInstaller.sh"

# Function to handle exits with an error message and status
exit_with_error() {
    echo "Error: $1" >&2
    echo "Action: $2" >&2
    exit "${3:-1}"
}

# Check for existing Docker installation
if command -v docker &> /dev/null; then
    exit_with_error "Docker already installed." "Verify with 'docker --version'." 0
fi

# Function to download the Docker installation script
download_script() {
    echo "Downloading Docker script from $GIST_URL..."
    curl -L "$GIST_URL" -o install_docker.sh || exit_with_error "Failed to download script." "Check your connection and URL." 1
}

# Function to run the installation script
run_installation() {
    if [ -s "install_docker.sh" ]; then
        echo "Script downloaded successfully."
        chmod +x install_docker.sh
        echo "Running the Docker script..."
        if sudo ./install_docker.sh; then
            echo "Docker installed successfully."
        else
            exit_with_error "Docker installation failed." "Review the script for issues." 1
        fi
    else
        exit_with_error "Downloaded script is empty or corrupted." "Check the script URL." 1
    fi
}

# Main script execution
download_script
run_installation

# Clean up the installation script
rm -f install_docker.sh
