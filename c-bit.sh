#!/bin/bash

ip=$(ifconfig | awk '/^eth0:/,/^$/' |awk 'NR==2 {print $2}')

echo "Installing Docker and Docker Compose..."
yes | sudo dnf install -y dnf-plugins-core
yes | sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose -y
sudo systemctl start docker
sudo systemctl enable docker
yes | sudo dnf install docker-compose

echo "Getting ID & Key JWN"
xdg-open https://bitwarden.com/host
read -p "Enter your install id:" id
read -p "Enter your install key:" key

echo "Downloading Bitwarden installation jawn..."
curl -Lso bitwarden.sh https://go.btwrdn.co/bw-sh
sudo chmod +x bitwarden.sh



echo "Running Bitwarden installation..."                       
sudo ./bitwarden.sh install << EOF
http://${ip}      # Domain name
vault             # Database name
$id               # Installation ID
$key              # Installation key
US                # Region (US or EU)
N                 # Do you have an SSL certificate to use
Y                 # Generate a self-signed SSL certificate
EOF


sleep 5 
./bitwarden.sh start

xdg-open http://${ip}
