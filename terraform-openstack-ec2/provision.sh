#!/usr/bin/bash

# Deploy with Terraform
echo "🚀 Running Terraform..."
terraform init
terraform plan -var-file="terraform.tfvars"
#terraform apply -var-file="terraform.tfvars" -auto-approve