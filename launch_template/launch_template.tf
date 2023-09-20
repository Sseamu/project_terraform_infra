resource "aws_launch_template" "philoberry_It" {
  name_prefix            = var.name_prefix
  image_id               = var.ami
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id] // ec2-sg 가져옴 이거 안되면 직접 여기서 sg 작성해서 적용해야함 근데 그렇게 안해도 될것같은데..
  description            = "My philoberry launch Template"
  key_name               = var.key_name


  # 태그 설정
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "My philoberry asg Instance"
      Environment = "dev"
    }

  }
}
