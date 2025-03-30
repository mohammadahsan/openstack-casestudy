#!/usr/bin/bash

echo "⚠️ Destroying infrastructure..."
/usr/bin/terraform destroy -var-file="terraform.tfvars" -auto-approve