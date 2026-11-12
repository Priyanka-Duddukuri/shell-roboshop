#!/bin/bash

AMI_ID="ami-0055977a6e828a4f4"
ZONE_ID="Z067637136H5BSGSMYVF8" # replace with your zone ID
DOMAIN_NAME="jhlittles.shop" # replace with your domain name

for instance in $@
do
    echo "Launching instance: $instance"
    INSTANCE_ID=$(aws ec2 run-instances \
        --image-id ami-0055977a6e828a4f4 \
        --instance-type t3.micro \
        --security-groups "roboshop-common" "roboshop-$instance" \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=roboshop-$instance}]" \
        --query 'Instances[0].InstanceId' \
        --output text
    )
    echo "Instance ID: $INSTANCE_ID"

    