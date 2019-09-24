#!/bin/bash

# install aws cli w/o sudo
pip install --user awscli
# put aws in the path
export PATH=$PATH:$HOME/.local/bin

# If it's a semver tag then deploy to production
if echo ${TRAVIS_TAG} | grep -c '^v\?[0-9]\+\.[0-9]\+\.[0-9]\+$'
then
    # use prod AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY envvars
    eval $(aws ecr get-login --region us-east-1 --no-include-email)
    docker tag keboola/docker-sandbox-ssl-proxy:latest 147946154733.dkr.ecr.us-east-1.amazonaws.com/keboola/docker-sandbox-ssl-proxy:$TRAVIS_TAG
    docker tag keboola/docker-sandbox-ssl-proxy:latest 147946154733.dkr.ecr.us-east-1.amazonaws.com/keboola/docker-sandbox-ssl-proxy:latest
    docker push 147946154733.dkr.ecr.us-east-1.amazonaws.com/keboola/docker-sandbox-ssl-proxy:$TRAVIS_TAG
    docker push 147946154733.dkr.ecr.us-east-1.amazonaws.com/keboola/docker-sandbox-ssl-proxy:latest
else
    echo "Skipping deployment to production, tag ${TRAVIS_TAG} is not semantic."
fi

# use devel AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY envvars
export AWS_ACCESS_KEY_ID=$DEVEL_AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$DEVEL_AWS_SECRET_ACCESS_KEY
eval $(aws ecr get-login --region us-east-1 --no-include-email)
docker tag keboola/docker-sandbox-ssl-proxy:latest 061240556736.dkr.ecr.us-east-1.amazonaws.com/keboola/docker-sandbox-ssl-proxy:$TRAVIS_TAG
docker tag keboola/docker-sandbox-ssl-proxy:latest 061240556736.dkr.ecr.us-east-1.amazonaws.com/keboola/docker-sandbox-ssl-proxy:latest
docker push 061240556736.dkr.ecr.us-east-1.amazonaws.com/keboola/docker-sandbox-ssl-proxy:$TRAVIS_TAG
docker push 061240556736.dkr.ecr.us-east-1.amazonaws.com/keboola/docker-sandbox-ssl-proxy:latest
