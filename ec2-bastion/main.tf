#보안그룹 먼저
variable "aws_security_group" "bastionhost_sg" {
  name             = "philoberry-bastion-sg-${var.service_type}"
  descrdescription = "philoberry-bastion-sg"
  vpc_id           = var.vpc_id

  #inbound규칙
  ingress {
    description = "bastion inbound ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_block  = ["0.0.0.0/0"]
  }
  egress {
    from_port  = 0
    to_port    = 0
    cidr_block = ["0.0.0.0/0"]
  }
  tags = {
    Name    = "philoberry-bastion-sg-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }
}

# Ec2 인스턴스 관련 내용

resource "aws_instance" "basion_ec2" {
  ami                    = "ami-0c9c942bd7bf113a2" //ubuntu
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.public_subnet1_id                      //public subnet                    // git 에 업로드 되기에 보여주면 안됨
  vpc_security_group_ids = [var.aws_security_group.bastionhost_sg.id] // bastion host sg
  availability_zone      = "ap-northeast-2a"
  //스토리지 추가
  root_block_device {
    volume_size = 8
    volume_type = "gp2" //볼륨 유형 
  }
  tags = {
    Name    = "philoberry-bastion-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }

}


#탄력적 IP 주소할당

resource "aws_eip" "eip" {
  instance = aws_instance.basion_ec2.id
  domain   = "vpc"

  tags = {
    Name    = "philoberry-ec2-eip-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }
}
