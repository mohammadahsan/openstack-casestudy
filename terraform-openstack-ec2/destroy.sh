#!/usr/bin/bash


#!/usr/bin/bash

LOG_FILE="/home/ubuntu/openstack-casestudy/automation/logs/destroy.log"

{
    echo "[$(/usr/bin/date)] START: Terraform Destroy"

    export PATH=$PATH:/usr/bin:/usr/local/bin

    /usr/bin/terraform destroy -var-file="terraform.tfvars" -auto-approve

    echo "[$(/usr/bin/date)] END: Terraform Destroy"
} >> "$LOG_FILE" 2>&1