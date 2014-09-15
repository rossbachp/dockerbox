#!/bin/bash
DATE=`date +'%Y%m%d%H%M'`
ACCOUNT=rossbachp
IMAGE=$(basename $(dirname `pwd`/Dockerfile))
IMAGETAG=${ACCOUNT}/${IMAGE}:${DATE}

echo "= build image $IMAGETAG"
docker build -t="$IMAGETAG" .
BUILDID=$(docker inspect -f "{{.Id}}" $IMAGETAG)

echo "= squash image $IMAGETAG"
docker save $BUILDID | docker-squash -t $IMAGETAG-squash -from root | docker load
SQUASHID=$(docker inspect -f "{{.Id}}" $IMAGETAG-squash)
docker tag $SQUASHID ${ACCOUNT}/${IMAGE}:latest

if [ "$1" == "-rmi" ] ; then
  echo "= remove build image $IMAGETAG with id $BUILDID"
  docker rmi $BUILDID
fi
