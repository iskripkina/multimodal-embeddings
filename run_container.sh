#!/bin/bash

YOUR_HASHED_PASSWORD=sha1:43bb79968cf9:e8fb443c6f57e7c9f29ab112d8d4e0d5b5571fbf

BIND_PORT="-p 8899:8888"
if (( $# >= 1 ))
then
    BIND_PORT=""
fi


CMD="docker"
#if which nvidia-docker
#then
#    CMD="nvidia-docker"
#fi

NV_GPU=0 $CMD run -ti --rm --name multimodal-embeddings \
    -e "HASHED_PASSWORD=$YOUR_HASHED_PASSWORD" \
    -e "SSL=1" \
    -v `pwd`/certs:/jupyter/certs \
    -v `pwd`:/notebook \
     --shm-size=2048m \
    $BIND_PORT \
    multimodal-embeddings \
    $@
