#!/bin/bash

echo "Select dev or prod"
read input

if [ -z "$input" ] || ([ $input != 'dev' ] && [ $input != 'prod' ]) ; then
    echo "exit"
    exit
fi

NAME=laravel
PROJECT_NAME=${NAME}-${input}
CONTAINER=('web' 'app')
IMAGE_VERSION=1.0.0
DOCKERFILE_PATH=./infra/docker/
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --profile private | sed -n 's|.*"Account": "\([^"]*\)".*|\1|p')
REPOSITORY_URL=${AWS_ACCOUNT_ID}.dkr.ecr.ap-northeast-1.amazonaws.com

aws ecr get-login-password --profile private | docker login --username AWS --password-stdin https://${REPOSITORY_URL}

for CONTAINER_NAME in "${CONTAINER[@]}"
do
    echo ${CONTAINER_NAME} start
    docker build -t ${PROJECT_NAME}-${CONTAINER_NAME}:${IMAGE_VERSION} . -f ${DOCKERFILE_PATH}${CONTAINER_NAME}/Dockerfile
    docker tag ${PROJECT_NAME}-${CONTAINER_NAME}:${IMAGE_VERSION} ${REPOSITORY_URL}/${PROJECT_NAME}-${CONTAINER_NAME}:${IMAGE_VERSION}
    docker push ${REPOSITORY_URL}/${PROJECT_NAME}-${CONTAINER_NAME}:${IMAGE_VERSION}
done
