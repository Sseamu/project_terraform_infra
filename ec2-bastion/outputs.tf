#탄력적 ip
output "eip_ip" {
  value = aws_eip.eip.public_ip
}
