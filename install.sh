#!/bin/bash
sudo apt-get install  openjdk-11-jdk -y
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
    /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y
sudo apt-get install jenkins -y
sudo apt-get update -y
sudo apt-get install docker.io -y
sudo apt-get install python3-pip -y
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.5/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo usermod -aG docker $USER
sudo usermod -aG docker jenkins
sudo service docker restart
sudo service jenkins restart
echo "Password to Jenkins "
cat  /var/lib/jenkins/secrets/initialAdminPassword
exit
