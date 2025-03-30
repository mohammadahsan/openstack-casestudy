#!/usr/bin/bash

# Deploy with Terraform
echo "🚀 Running Terraform..."
/usr/bin/terraform init
/usr/bin/terraform -var-file="terraform.tfvars"
/usr/bin/terraform apply -var-file="terraform.tfvars" -auto-approve