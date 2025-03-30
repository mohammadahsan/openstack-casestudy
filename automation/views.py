import os
import subprocess
from django.shortcuts import render

# Directories to store logs and statuses
BASE_DIR = "/home/ubuntu/openstack-casestudy/automation"
LOG_DIR = os.path.join(BASE_DIR, "logs")
STATUS_DIR = os.path.join(LOG_DIR, "status")

# Ensure dirs exist
os.makedirs(LOG_DIR, exist_ok=True)
os.makedirs(STATUS_DIR, exist_ok=True)

def run_in_background(name, command, cwd):
    status_file = os.path.join(STATUS_DIR, f"{name}_status.txt")
    log_file = os.path.join(LOG_DIR, f"{name}.log")

    # Prevent re-run if already running
    if os.path.exists(status_file):
        with open(status_file) as f:
            if f.read().strip() == "running":
                return "already_running"

    # Mark as running
    with open(status_file, "w") as f:
        f.write("running")

    # Start background process
    with open(log_file, "w") as out:
        subprocess.Popen(
            command,
            cwd=cwd,
            stdout=out,
            stderr=subprocess.STDOUT,
        )

    return "started"

def tail_log(name, lines=50):
    path = os.path.join(LOG_DIR, f"{name}.log")
    if os.path.exists(path):
        with open(path) as f:
            return "".join(f.readlines()[-lines:])
    return "No output yet."

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
    terraform_status = ""
    ansible_status = ""
    destroy_status = ""

    if request.method == "POST":
        action = request.POST.get("action")

        if action == "provision":
            terraform_status = run_in_background(
                "terraform",
                ["/usr/bin/bash", "provision.sh"],
                "/home/ubuntu/openstack-casestudy/terraform-openstack-ec2"
            )
        elif action == "destroy":
            destroy_status = run_in_background(
                "destroy",
                ["/usr/bin/bash", "destroy.sh"],
                "/home/ubuntu/openstack-casestudy/terraform-openstack-ec2"
            )
        elif action == "run_ansible":
            ansible_status = run_in_background(
                "ansible",
                ["/usr/bin/ansible-playbook", "playbook.yaml"],
                "/home/ubuntu/openstack-casestudy/ansible"
            )

    ec2_instances_output = get_ec2_list()

    return render(request, "automation.html", {
        "terraform_status": terraform_status,
        "terraform_output": tail_log("terraform"),
        "destroy_status": destroy_status,
        "destroy_output": tail_log("destroy"),
        "ansible_status": ansible_status,
        "ansible_output": tail_log("ansible"),
        "ec2_instances_output": ec2_instances_output
    })