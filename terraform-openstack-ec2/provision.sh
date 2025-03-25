#!/bin/bash

# Fetch your current public IP
echo "🌐 Fetching your public IP..."
MY_IP=$(curl -s https://ipv4.lafibre.info/ip.php)

if [[ -z "$MY_IP" ]]; then
  echo "❌ Failed to fetch public IP."
  exit 1
fi

echo "✅ Your IP is: $MY_IP"

# Clean up any existing 'your_ip' lines
echo "🧽 Removing old your_ip line..."
sed -i '' '/^your_ip *=/d' terraform.tfvars

# Ensure a newline at the end of file before appending
echo >> terraform.tfvars

# Append the new IP
echo "📦 Appending your_ip to terraform.tfvars..."
echo "your_ip        = \"${MY_IP}\"" >> terraform.tfvars

# Deploy with Terraform
echo "🚀 Running Terraform..."
terraform init
terraform apply -var-file="terraform.tfvars" -auto-approve