#!/bin/bash
echo "Note: you may need to add your docker-registry to /etc/sysconfig/docker "
echo "(on CentOS/RHEL/Fedora) for this to push to the registries correctly"


if [ -z "$USERNAME" ]; then
    echo "setting USERNAME to " `whoami`
    USERNAME=`whoami`
fi
exit()
if [ -z "$DOCKER_REGISTRY" ]; then
    echo "setting DOCKER_REGISTRY to localhost:5000"
    DOCKER_REGISTRY=localhost:5000
fi
echo "using USERNAME=$USERNAME"
echo "using DOCKER_REGISTRY=$DOCKER_REGISTRY"

BASE_DIR=`pwd`
echo "building docker-compose-sample-atomicapp"
cd docker-compose-sample-atomicapp
docker build -t $USERNAME/docker-compose-sample-atomicapp --file="Dockerfile" .
docker tag -f $USERNAME/docker-compose-sample-atomicapp $DOCKER_REGISTRY/docker-compose-sample-atomicapp$TAG
echo "pushing to $DOCKER_REGISTRY/docker-compose-sample-atomicapp$TAG"
docker push $DOCKER_REGISTRY/docker-compose-sample-atomicapp$TAG
echo "build complete: docker-compose-sample-atomicapp"
cd $BASE_DIR
