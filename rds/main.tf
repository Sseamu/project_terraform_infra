# 보안 그륩
# 위치 : EC2 > 네트워크 및 보안 > 보안 그룹
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
resource "aws_security_group" "rds_sg" {
  name        = "philoberry-db-sg-${var.service_type}" //보안그룹이름을 서비스타입으로 구분하기위해서
  description = "philoberry db security group production"
  vpc_id      = var.vpc_id
  # 인바운드 규칙   
  ingress {
    description = "philoberry_rds_ingress"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "philoberry-db-sg-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }
}

# 서브넷 그룹 생성 (private subnet 2개)
# 위치 : RDS > 서브넷 그룹
resource "aws_db_subnet_group" "subnet-group" {
  name       = "saju-private-subnet-group-${var.service_type}"
  subnet_ids = [var.private_subnet1_id, var.private_subnet2_id]

  tags = {
    Name    = "saju-private-subnet-group-${var.service_type}"
    Service = "saju-${var.service_type}"
  }
}
