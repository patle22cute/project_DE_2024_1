#!/bin/bash

# Download Anacoda installer
echo "Download the installer"
wget https://repo.anaconda.com/archive/Anaconda3-2021.11-Linux-x86_64.sh

# Run the installer scripts
echo "run the installer scripts"
bash Anaconda3-2021.11-Linux-x86_64.sh -b -p ~/anaconda

# Remove the installer scripts if descired
echo "remove the installer scripts"
rm Anaconda3-2021.11-Linux-x86_64.sh

# Location install Anaconda
echo "activate conda"
eval "$HOME/anaconda/bin/conda shell.bash hook)"

echo "running the conda init"
conda init

echo "update Anaconda"
conda update -y conda

# Install Docker/Docker-compose
# update package list
sudo apt-get update

echo "Installing Docker..."
sudo apt-get -y install docker.io

echo "Docker without sudo setup..."
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo service docker restart

echo "Installing docker-compose..."
cd 
mkdir -p bin
cd bin
wget https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-x86_64 -O docker-compose
sudo chmod +x docker-compose

echo "Setup .bashrc..."
echo '' >> ~/.bashrc
echo 'export PATH=${HOME}/bin:${PATH}' >> ~/.bashrc
eval "$(cat ~/.bashrc | tail -n +10)" # A hack because source .bashrc doesn't work inside the script

echo "docker-compose version..."
docker-compose --version

mkdir -p ~/.google/credentials
