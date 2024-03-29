#!/bin/bash

source .env

if [ -z ${DOCKER_USERNAME} ]; then
    echo "Missing DOCKER_USERNAME variable!"
    exit 1
fi

error() {
    if [ $? != 0 ]; then
        echo "Error!"
        exit 122
    fi
}

docker_login() {
    echo "=> Logging in $DOCKER_USERNAME"
    echo "$DOCKER_TOKEN" | docker login -u $DOCKER_USERNAME --password-stdin
    echo "=> Logged $DOCKER_USERNAME"
}

build() {
    echo "=> Building ${1}"
    docker build -t ${1} .
    echo "=> Built ${1}"
}

tag() {
    echo "=> Tagging ${1}"
    docker tag ${1} $(echo $DOCKER_USERNAME)/${1}
    echo "=> Tagged ${1}"
}

push() {
    echo "=> Pushing ${1}"
    docker push $(echo $DOCKER_USERNAME)/${1}
    echo "=> Pushed ${1}"
}

docker_login

build ${1}
error

tag ${1}
error

push ${1}
error

echo

exit 0