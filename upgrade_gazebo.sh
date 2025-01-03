#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

# Install Gazebo 11, skip if already installed
sudo apt install --no-upgrade gazebo11 libgazebo11-dev -y

# Get the installed Gazebo version
gazebo_version=$(gazebo --version | grep -oP '\d+\.\d+\.\d+')

# Define the versions to compare
version_113="1.13.0"
version_115="1.15.0"

# Compare the versions using sort -V
if [ "$(printf "%s\n%s" "$gazebo_version" "$version_113" | sort -V | head -n1)" = "$gazebo_version" ] || \
   [ "$gazebo_version" = "$version_115" ]; then
    # If the version is less than 1.14.0, equal to 1.15.0:
    echo "\033[33mThe current Gazebo version is $gazebo_version, which is incompatible. Installing the latest Gazebo...\033[0m"

    # Check if Gazebo's stable source has been added
    if [ ! -f /etc/apt/sources.list.d/gazebo-stable.list ]; then
        # If not, add the Gazebo repository
        echo "\033[33mAdding Gazebo stable source...\033[0m"
        sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
        # Add the Gazebo GPG key
        wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
    fi

    # Update the package list
    sudo apt-get update -y --quiet

    # Install the latest version of Gazebo
    sudo apt install gazebo11 libgazebo11-dev -y
fi

# Get the installed Gazebo version after the update
gazebo_version=$(gazebo --version | grep -oP '\d+\.\d+\.\d+')
echo "\e[32mThe current installed Gazebo version is $gazebo_version.\e[0m"

