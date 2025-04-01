#!/usr/bin/bash

# Vars
CONTROLLER_NAME="openstack-ec2-1"
COMPUTE_NAME="openstack-ec2-2"
REGION="eu-west-1"

# Get IPs
controller_ip=$(aws ec2 describe-instances \
  --region "$REGION" \
  --filters "Name=tag:Name,Values=$CONTROLLER_NAME" "Name=instance-state-name,Values=running" \
  --query "Reservations[*].Instances[*].PrivateIpAddress" --output text)

compute_ip=$(aws ec2 describe-instances \
  --region "$REGION" \
  --filters "Name=tag:Name,Values=$COMPUTE_NAME" "Name=instance-state-name,Values=running" \
  --query "Reservations[*].Instances[*].PrivateIpAddress" --output text)

echo "Controller IP: $controller_ip"
echo "Compute IP: $compute_ip"

# Paths
controller_tpl="/home/ubuntu/openstack-casestudy/ansible/roles/devstack_controller/templates/local.conf.j2"
compute_tpl="/home/ubuntu/openstack-casestudy/ansible/roles/devstack_compute/templates/local.conf.j2"

# Replace placeholders with real IPs
sed -i "s/controller_ip/$controller_ip/g" "$controller_tpl"
sed -i "s/controller_ip/$controller_ip/g" "$compute_tpl"
sed -i "s/compute_ip/$compute_ip/g" "$compute_tpl"

echo "✅ Done replacing controller_ip and compute_ip placeholders!"

STATUS_FILE="/home/ubuntu/openstack-casestudy/automation/logs/status/ansible_status.txt"

export PATH=$PATH:/usr/bin:/usr/local/bin

/usr/bin/ansible-playbook playbook.yaml

echo "successful" > "$STATUS_FILE"