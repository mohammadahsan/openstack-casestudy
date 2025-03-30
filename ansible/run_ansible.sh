#!/usr/bin/bash

LOG_FILE="/home/ubuntu/openstack-casestudy/automation/logs/ansible.log"

{
    echo "[$(/usr/bin/date)] START: Ansible Playbook"

    export PATH=$PATH:/usr/bin:/usr/local/bin

    /usr/bin/ansible-playbook playbook.yaml

    echo "[$(/usr/bin/date)] END: Ansible Playbook"
} >> "$LOG_FILE" 2>&1