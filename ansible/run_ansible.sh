#!/usr/bin/bash

STATUS_FILE="/home/ubuntu/openstack-casestudy/automation/logs/status/ansible_status.txt"

export PATH=$PATH:/usr/bin:/usr/local/bin

/usr/bin/ansible-playbook playbook.yaml

echo "successful" > "$STATUS_FILE"