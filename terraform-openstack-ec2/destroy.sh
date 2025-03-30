#!/usr/bin/bash

echo "[`date`] START: Terraform Destroy"

echo "⚠️ Destroying infrastructure..."
/usr/bin/terraform destroy -var-file="terraform.tfvars" -auto-approve

echo "[`date`] END: Terraform Destroy"