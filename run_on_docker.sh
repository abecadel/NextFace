#!/bin/bash
echo "Building docker image"
docker build -t nextface .
echo "Running container..."
echo "type in: conda activate faceNext"
docker run --gpus all -v /home/michal/workspace/NextFace:/app -it nextface bash
