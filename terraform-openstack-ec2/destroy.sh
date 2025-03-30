#!/usr/bin/bash

echo "⚠️ Destroying infrastructure..."
terraform destroy -var-file="terraform.tfvars" -auto-approve