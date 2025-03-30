import os
import subprocess
from django.shortcuts import render

BASE_DIR = "/home/ubuntu/openstack-casestudy/automation"
STATUS_DIR = os.path.join(BASE_DIR, "logs", "status")
os.makedirs(STATUS_DIR, exist_ok=True)

def run_in_background(name, script_path, cwd):
    status_file = os.path.join(STATUS_DIR, f"{name}_status.txt")

    # Avoid duplicate runs
    if os.path.exists(status_file):
        with open(status_file) as f:
            if f.read().strip() == "running":
                return

    # Mark as running
    with open(status_file, "w") as f:
        f.write("running")

    # Run background script
    subprocess.Popen(
        ["/usr/bin/bash", script_path],
        cwd=cwd
    )

def read_status(name):
    path = os.path.join(STATUS_DIR, f"{name}_status.txt")
    if os.path.exists(path):
        with open(path) as f:
            return f.read().strip()
    return "not started"

def get_ec2_list():
    try:
        process = subprocess.Popen(
            [
                "/usr/bin/aws", "ec2", "describe-instances",
                "--query", "Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name,PublicIpAddress,Tags[?Key=='Name'].Value | [0]]",
                "--output", "table"
            ],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        stdout, stderr = process.communicate()
        return stdout.decode() if stdout else stderr.decode()
    except Exception as e:
        return f"Error getting EC2 list: {str(e)}"

def automation_view(request):
    if request.method == "POST":
        action = request.POST.get("action")

        if action == "provision":
            run_in_background(
                "terraform",
                "provision.sh",
                "/home/ubuntu/openstack-casestudy/terraform-openstack-ec2"
            )
        elif action == "destroy":
            run_in_background(
                "destroy",
                "destroy.sh",
                "/home/ubuntu/openstack-casestudy/terraform-openstack-ec2"
            )
        elif action == "run_ansible":
            run_in_background(
                "ansible",
                "run_ansible.sh",
                "/home/ubuntu/openstack-casestudy/ansible"
            )

    return render(request, "automation.html", {
        "terraform_status": read_status("terraform"),
        "destroy_status": read_status("destroy"),
        "ansible_status": read_status("ansible"),
        "ec2_instances_output": get_ec2_list()
    })