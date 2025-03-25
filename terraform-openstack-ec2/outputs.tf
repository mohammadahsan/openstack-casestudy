output "public_ip" {
  value = aws_instance.openstack_ec2.public_ip
}

output "dns_name" {
  value = aws_route53_record.openstack_dns.fqdn
}

output "ssh_command" {
  value = "ssh ubuntu@${aws_route53_record.openstack_dns.fqdn}"
}