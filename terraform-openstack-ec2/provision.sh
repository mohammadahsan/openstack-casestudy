#!/usr/bin/bash

STATUS_FILE="/home/ubuntu/openstack-casestudy/automation/logs/status/terraform_status.txt"
DESTROY_STATUS="/home/ubuntu/openstack-casestudy/automation/logs/status/destroy_status.txt"

export PATH=$PATH:/usr/bin:/usr/local/bin

rm -rf .terraform/ .terraform.lock.hcl
/usr/bin/terraform init
#/usr/bin/terraform plan -var-file="terraform.tfvars"
/usr/bin/terraform apply -var-file="terraform.tfvars" -auto-approve

echo "provisioned" > "$STATUS_FILE"
echo "available to destroy" > "$DESTROY_STATUS"