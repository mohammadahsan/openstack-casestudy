data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = "${var.region}a"
}

data "aws_route53_zone" "selected" {
  name = var.domain_name
}

resource "aws_key_pair" "openstack_key" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

resource "aws_security_group" "openstack_sg" {
  name        = "openstack-sg"
  description = "Allow SSH, HTTP, HTTPS, and internal VPC traffic"
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

  ingress {
    description = "Allow all traffic from within the VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      for assoc in data.aws_vpc.default.cidr_block_associations : assoc.cidr_block
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "openstack-sg"
  }
}

resource "aws_instance" "openstack_ec2" {
  count                       = var.instance_count
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
    Name = "${var.instance_name}-${count.index + 1}"
  }
}

resource "aws_route53_record" "openstack_dns" {
  count   = var.instance_count
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "openstack${count.index + 1}.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.openstack_ec2[count.index].public_ip]
}