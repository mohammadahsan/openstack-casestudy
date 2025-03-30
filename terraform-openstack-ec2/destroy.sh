#!/usr/bin/bash

echo "[`/usr/bin/date`] START: Terraform Destroy"

echo "⚠️ Destroying infrastructure..."
/usr/bin/terraform destroy -var-file="terraform.tfvars" -auto-approve

echo "[`/usr/bin/date`] END: Terraform Destroy"