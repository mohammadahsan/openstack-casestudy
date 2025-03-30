#!/usr/bin/bash

STATUS_FILE="/home/ubuntu/openstack-casestudy/automation/logs/status/terraform_status.txt"

export PATH=$PATH:/usr/bin:/usr/local/bin

/usr/bin/terraform init
/usr/bin/terraform plan -var-file="terraform.tfvars"
#/usr/bin/terraform apply -var-file="terraform.tfvars" -auto-approve

echo "provisioned" > "$STATUS_FILE"