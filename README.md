# Openstack casestudy

This repository contains for provisioning of OpenStack on EC2 instance using Ansible.

## 
/home/ubuntu/openstack-casestudy/automation
python3 -m venv automation
source automation/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
pip install gunicorn
gunicorn --chdir /home/ubuntu/openstack-casestudy/automation -b 127.0.0.1:9000 wsgi



## Infrastructure Deployment

For full provisioning instructions and details, please refer to:

➡️ [terraform-openstack-ec2/README.md](terraform-openstack-ec2/README.md)

## OpenStack Deployment