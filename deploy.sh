#!/bin/bash

# install aws cli w/o sudo
pip install --user awscli
# put aws in the path
export PATH=$PATH:$HOME/.local/bin
# needs AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY envvars 
eval $(aws ecr get-login --region us-east-1 --no-include-email)
docker tag keboola/docker-sandbox-ssl-proxy:latest 147946154733.dkr.ecr.us-east-1.amazonaws.com/keboola/docker-sandbox-ssl-proxy:$TRAVIS_TAG
docker tag keboola/docker-sandbox-ssl-proxy:latest 147946154733.dkr.ecr.us-east-1.amazonaws.com/keboola/docker-sandbox-ssl-proxy:latest
docker push 147946154733.dkr.ecr.us-east-1.amazonaws.com/keboola/docker-sandbox-ssl-proxy:$TRAVIS_TAG
docker push 147946154733.dkr.ecr.us-east-1.amazonaws.com/keboola/docker-sandbox-ssl-proxy:latest
