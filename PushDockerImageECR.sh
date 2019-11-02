#!/usr/bin/env bash

echo "Push Image For ECR.\n"

#### Config.
# Set DATESTR.
DATESTR=`date +%Y%m%d%H%M%S`
echo "TAG:"${DATESTR}

# Set ECR NAME.
ECR_NAME="php-sample-container"
echo "REPOSITORY_NAME:"${ECR_NAME}

# Set AWS Account No.
AWS_NO="930006624817"
echo "AWS_NO:"${AWS_NO}

# Set AWS REGION .
AWS_REGION="ap-northeast-1"
echo "AWS_REGION:"${AWS_REGION}

# Set AWS Profile .
AWS_PROFILE="nishimu0507"
echo "AWS_PROFILE:"${AWS_PROFILE}


#### Exec
# Login.
$(aws ecr get-login --no-include-email --region ${AWS_REGION} --profile ${AWS_PROFILE})

# Build
docker build -t ${ECR_NAME} .

# Add TAG
docker tag ${ECR_NAME}:latest ${AWS_NO}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_NAME}:${DATESTR}

# Push
docker push ${AWS_NO}.dkr.ecr.${AWS_REGION}.amazonaws.com/${ECR_NAME}:${DATESTR}


echo "THE END..\n"