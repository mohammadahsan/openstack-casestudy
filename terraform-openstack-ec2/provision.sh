#!/usr/bin/bash
# Deploy with Terraform
echo "🚀 Running Terraform..."

LOG_FILE="/home/ubuntu/openstack-casestudy/automation/logs/terraform.log"

{
    echo "[$(/usr/bin/date)] START: Terraform Provisioning"

    export PATH=$PATH:/usr/bin:/usr/local/bin

    /usr/bin/terraform init
    /usr/bin/terraform plan -var-file="terraform.tfvars"
    #/usr/bin/terraform apply -var-file="terraform.tfvars" -auto-approve

    echo "[$(/usr/bin/date)] END: Terraform Provisioning"
} >> "$LOG_FILE" 2>&1