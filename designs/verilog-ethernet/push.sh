#!/bin/bash

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 072422391281.dkr.ecr.us-east-1.amazonaws.com

docker tag verilog-ethernet-bits:latest 072422391281.dkr.ecr.us-east-1.amazonaws.com/vivado:verilog-ethernet-v1.0

docker push 072422391281.dkr.ecr.us-east-1.amazonaws.com/vivado:verilog-ethernet-v1.0
