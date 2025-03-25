data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = "${var.region}a" # Adjust if needed
  #map_public_ip_on_launch = true
}

resource "aws_key_pair" "openstack_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "openstack_sg" {
  name        = "openstack-sg"
  description = "Allow SSH, HTTP, and HTTPS"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.your_ip}/32"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "openstack_ec2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.default.id
  vpc_security_group_ids      = [aws_security_group.openstack_sg.id]
  key_name                    = aws_key_pair.openstack_key.key_name
  associate_public_ip_address = true

  root_block_device {
    volume_size = 100
    volume_type = "gp3"
  }

  tags = {
    Name = var.instance_name
  }
}

resource "aws_route53_record" "openstack_dns" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${var.record_name}.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.openstack_ec2.public_ip]
}

data "aws_route53_zone" "selected" {
  name = var.domain_name
}