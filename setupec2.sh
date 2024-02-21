#!/bin/bash

# install docker on EC2
sudo apt-get update
sudo apt-get install docker.io -y
sudo systemctl start docker
sudo docker run --detach --name watchtower --volume /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower
# query the account id
ACCOUNT_ID=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep -oP '"accountId"\s*:\s*"\K[^"]+')
# run docker image from ecr repository. name of the image: elm-ros2-repo
sudo apt install -y amazon-ecr-credential-helper
# echo 
# {
#   "credsStore": "ecr-login"
# }
# > /home/ubuntu/.docker/config.json
mkdir -p /home/ubuntu/.docker
echo "{\"credsStore\": \"ecr-login\"}" > /home/ubuntu/.docker/config.json
export AWS_REGION=us-east-2
docker-credential-ecr-login list
sleep 5
docker-credential-ecr-login list
sudo docker --config /home/ubuntu/.docker run -d $ACCOUNT_ID.dkr.ecr.us-east-2.amazonaws.com/elm-ros2-repo