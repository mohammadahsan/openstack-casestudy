# Terraform EC2 Deployment - openstack.opsbyak.com

This project uses Terraform to create an Ubuntu 22.04 EC2 instance in AWS with:
- Public DNS via Route53: `openstack.opsbyak.com`
- 100GB SSD root volume
- Public access on ports 80 and 443
- SSH access on port 22 restricted to your current public IP only
- Automatic deployment via a shell script

---

## 1. Set AWS Credentials

Before running anything, export your AWS credentials in your terminal:

```bash
export AWS_ACCESS_KEY_ID="your-access-key-id"
export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
export AWS_DEFAULT_REGION="eu-west-1"
```

Verify credentials:

```bash
aws sts get-caller-identity
```

---

## 2. Prepare the Project

Make sure these files are present:

```
terraform-openstack-ec2/
├── main.tf
├── variables.tf
├── outputs.tf
├── terraform.tfvars
├── deploy.sh
└── destroy.sh
```

Make the shell scripts executable:

```bash
chmod +x deploy.sh destroy.sh
```

---

## 3. Deploy the Infrastructure

Run:

```bash
./deploy.sh
```

This will:
- Fetch your public IP
- Clean and update `terraform.tfvars` with `your_ip`
- Run `terraform init` and `terraform apply`

---

## 4. Access the EC2 Instance

After successful deployment, SSH into your instance:

```bash
ssh ubuntu@openstack.opsbyak.com
```

---

## 5. Destroy Infrastructure

To clean up everything:

```bash
./destroy.sh
```

---

## 6. SSH Known Hosts Tip

If the IP of your instance changes and SSH throws a warning, remove the known host entry:

```bash
ssh-keygen -R openstack.opsbyak.com
```

---

## Notes

- The instance is launched in the default VPC, in a public subnet
- Volume size is set to 100GB (gp3)
- Port 22 is restricted to your IP using `curl https://ipv4.lafibre.info/ip.php`
- Route53 is used to map the public IP to `openstack.opsbyak.com`
