#!/usr/bin/bash

STATUS_FILE="/home/ubuntu/openstack-casestudy/automation/logs/status/destroy_status.txt"
TERRAFORM_STATUS="/home/ubuntu/openstack-casestudy/automation/logs/status/terraform_status.txt"
ANSIBLE_STATUS="/home/ubuntu/openstack-casestudy/automation/logs/status/ansible_status.txt"

export PATH=$PATH:/usr/bin:/usr/local/bin

rm -rf .terraform/ .terraform.lock.hcl
/usr/bin/terraform init

/usr/bin/terraform destroy -var-file="terraform.tfvars" -auto-approve

echo "destroyed" > "$STATUS_FILE"

echo "" > "$TERRAFORM_STATUS"
echo "" > "$ANSIBLE_STATUS"


rm -rf $TERRAFORM_STATUS
rm -rf $ANSIBLE_STATUS
rm -rf $STATUS_FILE