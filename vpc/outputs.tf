output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnet1_id" {
  value = aws_subnet.public-subnet-1.id
}

output "public_subnet2_id" {
  value = aws_subnet.public-subnet-2.id
}

output "private_subnet1_id" {
  value = aws_subnet.private-subnet-1.id
}

output "private_subnet2_id" {
  value = aws_subnet.private-subnet-2.id
}

output "private_subnet3_id" {
  value = aws_subnet.private-subnet-3.id
}

output "private_subnet4_id" {
  value = aws_subnet.private-subnet-4.id
}
