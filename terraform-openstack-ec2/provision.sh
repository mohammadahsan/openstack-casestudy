#!/usr/bin/bash

echo "[`date`] START: Terraform Provisioning"


# Deploy with Terraform
echo "🚀 Running Terraform..."
/usr/bin/terraform init
/usr/bin/terraform plan -var-file="terraform.tfvars"
#/usr/bin/terraform apply -var-file="terraform.tfvars" -auto-approve

echo "[`date`] END: Terraform Provisioning"