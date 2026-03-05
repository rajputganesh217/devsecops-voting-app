#!/bin/bash

# Update system

apt-get update -y

# Install basic tools

apt-get install -y git curl unzip

# Install Java (required for Jenkins)

apt-get install -y openjdk-17-jdk

# Install Docker

apt-get install -y docker.io
systemctl enable docker
systemctl start docker

# Install kubectl

snap install kubectl --classic

# Install Azure CLI

curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Add Jenkins repository

curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | tee 
/usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] 
https://pkg.jenkins.io/debian binary/ > 
/etc/apt/sources.list.d/jenkins.list

# Install Jenkins

apt-get update -y
apt-get install -y jenkins

# Start Jenkins

systemctl enable jenkins
systemctl start jenkins

# Add users to docker group

usermod -aG docker jenkins
usermod -aG docker azureuser
