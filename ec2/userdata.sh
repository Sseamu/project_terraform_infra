#!/bin/bash
sudo yum update -y
#git 설치
sudo yum install -y git
#docker install
sudo amazon-linux-extras install docker -y
                
sudo service docker start
sudo systemctl enable docker

# Add the ec2-user to the docker group 
sudo usermod -a -G docker ec2-user