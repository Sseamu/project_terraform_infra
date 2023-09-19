resource "aws_security_group" "philoberry_sg" {
  name        = "philoberry-api-sg-${var.service_type}"
  description = "philoberry api sg production"
  vpc_id      = var.vpc_id
  # 인바운드 규칙   
  dynamic "ingress" {
    for_each = var.port
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "philoberry-api-sg-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }
}


# EC2
# 위치 : EC2 > 인스턴스 > 인스턴스
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance
resource "aws_instance" "ec2" {
  ami                    = "ami-0f22ac1c12807aefc"               //AMI 선택(아마존리눅스lts -2 )
  instance_type          = var.instance_type                     //인스턴스 유형
  key_name               = "philoberry-keypair"                  //기존 키 페어 선택
  subnet_id              = var.private_subnet1_id                //서브넷
  vpc_security_group_ids = [aws_security_group.philoberry_sg.id] //기존 보안 그룹 선택
  availability_zone      = "ap-northeast-2a"                     //가용 영역
  user_data              = file("${path.module}/userdata.sh")    // 코드에서 ${path.module}은 현재 모듈이 위치한 디렉토리 경로
  //스토리지 추가
  root_block_device {
    volume_size = 30    //크기(GB)
    volume_type = "gp2" //볼륨 유형
  }

  tags = {
    Name    = "philoberry-api-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }
}
