# 프라이빗 IP
output "private_ip" {
  value = aws_instance.ec2.private_ip
}

# sg
output "ec2_sg_id" {
  value = aws_security_group.philoberry_sg.id
}
