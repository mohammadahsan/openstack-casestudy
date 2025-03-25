output "public_ips" {
  value = aws_instance.openstack_ec2[*].public_ip
}

output "dns_names" {
  value = aws_route53_record.openstack_dns[*].fqdn
}

output "ssh_commands" {
  value = [for dns in aws_route53_record.openstack_dns[*].fqdn : "ssh ubuntu@${dns}"]
}