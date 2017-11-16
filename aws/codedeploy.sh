#!/bin/bash

deploy_application () {
  aws deploy push \
    --application-name $1-qa \
    --s3-location s3://af-$1-qa-codedeploy-us-west-2/$1_manual.zip \
    --ignore-hidden-files \
    --source . \
    --region us-west-2 \
    --profile appfolio-qa \
  && \  
  aws deploy create-deployment \
    --application-name $1-qa \
    --deployment-group-name $1-qa-DG \
    --s3-location bucket=af-$1-qa-codedeploy-us-west-2,key=$1_manual.zip,bundleType=zip \
    --profile appfolio-qa \
    --region us-west-2
}

