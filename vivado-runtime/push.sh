#!/bin/bash

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 072422391281.dkr.ecr.us-east-1.amazonaws.com

docker tag vivado-runtime:latest 072422391281.dkr.ecr.us-east-1.amazonaws.com/vivado:v2023.2

docker push 072422391281.dkr.ecr.us-east-1.amazonaws.com/vivado:v2023.2
