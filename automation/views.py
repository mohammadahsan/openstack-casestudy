from subprocess import Popen, PIPE
from django.shortcuts import render

def automation_view(request):
    terraform_output = ""
    destroy_output = ""
    ansible_output = ""
    ec2_instances_output = ""

    if request.method == "POST":
        action = request.POST.get("action")

        if action == "provision":
            process = Popen(
                ["/usr/bin/bash", "provision.sh"],
                cwd="/home/ubuntu/openstack-casestudy/terraform-openstack-ec2",
                stdout=PIPE, stderr=PIPE
            )
            stdout, stderr = process.communicate()
            terraform_output = stdout.decode() + stderr.decode()

        elif action == "destroy":
            process = Popen(
                ["/usr/bin/bash", "destroy.sh"],
                cwd="/home/ubuntu/openstack-casestudy/terraform-openstack-ec2",
                stdout=PIPE, stderr=PIPE
            )
            stdout, stderr = process.communicate()
            destroy_output = stdout.decode() + stderr.decode()

        elif action == "run_ansible":
            process = Popen(
                ["/usr/bin/ansible-playbook", "playbook.yaml"],
                cwd="/home/ubuntu/openstack-casestudy/ansible",
                stdout=PIPE, stderr=PIPE
            )
            stdout, stderr = process.communicate()
            ansible_output = stdout.decode() + stderr.decode()

        # Optional EC2 list via ping
        try:
            list_proc = Popen(
                ["/usr/bin/ansible", "all", "-m", "ping"],
                cwd="/home/ubuntu/openstack-casestudy/ansible",
                stdout=PIPE, stderr=PIPE
            )
            out, err = list_proc.communicate()
            ec2_instances_output = out.decode() + err.decode()
        except Exception as e:
            ec2_instances_output = str(e)

    return render(request, "automation.html", {
        "terraform_output": terraform_output,
        "destroy_output": destroy_output,
        "ansible_output": ansible_output,
        "ec2_instances_output": ec2_instances_output,
    })