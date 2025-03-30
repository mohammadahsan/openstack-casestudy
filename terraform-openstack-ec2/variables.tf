variable "region" {
  description = "AWS region"
  default     = "eu-west-1"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  default     = "openstack-ec2"
}

variable "ami" {
  description = "Ubuntu 22.04 AMI ID for eu-west-1"
  default     = "ami-07661c9ecd302a7aa" # Ensure this is the correct AMI ID for Ubuntu 22.04 in eu-west-1
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  default     = "openstack-key"
}

variable "domain_name" {
  description = "Domain name for Route53"
  default     = "opsbyak.com"
}

variable "record_name" {
  description = "Subdomain for the EC2 instance"
  default     = "openstack"
}

variable "public_key_path" {
  description = "Path to the public SSH key"
  default     = "~/.ssh/id_rsa.pub"
}

variable "your_ip" {
  description = "Your public IP address"
  default     = "20.161.75.209" # Replace with your actual public IP
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 2
}