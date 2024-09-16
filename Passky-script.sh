#!/bin/bash

ip=$(ifconfig | awk '/^eth0:/,/^$/' |awk 'NR==2 {print $2}')

yes | sudo dnf install -y dnf-plugins-core
yes | sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
yes | sudo dnf install docker-compose
git clone https://github.com/Rabbit-Company/Passky-Server.git
cd Passky-Server
sudo docker-compose up -d
xdg-open http://${ip}:8080/