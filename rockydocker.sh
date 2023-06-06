#!/usr/bin/env bash 

## Script to install docker-ce on Rocky Linux
## Run using `sudo rocky-docker.sh`

# Ensuring "GROUP" variable has not been set elsewhere
unset GROUP

echo "Removing podman and installing Docker CE"
dnf remove -y podman buildah
dnf install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "Setting up docker service"
systemctl enable docker
systemctl start docker
systemctl status docker

echo "Adding permissions to current user for docker, attempting to reload group membership"
usermod -aG docker -a $USER
GROUP=$(id -g)
newgrp docker
newgrp $GROUP
unset GROUP

echo "Install completed"
docker ps
