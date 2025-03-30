# Openstack casestudy

This repository contains for provisioning of OpenStack on EC2 instance using Ansible.

---

### 🖱️ How to Use the Dashboard

Once the dashboard is running and accessible at [https://automation.opsbyak.com](https://automation.opsbyak.com), here's how to use it:

---

#### 🔘 1. Provision Infrastructure

- Click the **"Provision Infrastructure"** button.
- This triggers `provision.sh` in the background using Terraform.
- **Status will update** from `not started` → `running` → `provisioned` once completed.
- If it's already running, clicking the button will show `already_running`.

---

#### 🗑️ 2. Destroy Infrastructure

- Click the **"Destroy Infrastructure"** button.
- This runs `destroy.sh` to destroy the Terraform-managed resources.
- **Status will update** to `destroyed`.
- It also automatically clears the **provision status**.

---

#### 🧰 3. Run Ansible

- Click the **"Run Ansible"** button.
- This executes `run_ansible.sh`, which runs `ansible-playbook playbook.yaml`.
- **Status will update** to `successful` once the playbook finishes.

---

#### ☁️ 4. View EC2 Instances

- Scroll down to the **"EC2 Instances"** section.
- The list auto-refreshes on every page load.
- It shows instance ID, type, state, IP, and Name tag via AWS CLI.

---

#### 🔗 5. OpenStack Links

- Two static links are provided at the bottom:
  - [https://openstack1.opsbyak.com](https://openstack1.opsbyak.com)
  - [https://openstack2.opsbyak.com](https://openstack2.opsbyak.com)

These open in a new tab for convenience.

---

#### 🔄 6. Refresh Statuses

- Refreshing the page will **not trigger any new actions**.
- It will **only re-fetch the current statuses** from status files and re-display them.
- You can safely refresh to monitor ongoing operations.

---

#### ⚠️ Notes

- No logs are shown in the UI by design — this is a **status-only dashboard**.
- If you need debug info, check system logs or backend scripts.

---
## Infrastructure Deployment

For full provisioning instructions and details, please refer to:

➡️ [terraform-openstack-ec2/README.md](terraform-openstack-ec2/README.md)

## OpenStack Deployment

