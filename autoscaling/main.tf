resource "aws_launch_template" "philoberry_It" {
  name_prefix   = var.name_prefix
  image_id      = var.ami
  instance_type = var.instance_type
  description   = "My philoberry launch Template"

  # ... additional configuration ...
}

resource "aws_autoscaling_group" "asg" {
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = [aws_subnet.private-subnet-1.id, aws_subnet.private-subnet-2.id]
  health_check_type   = "EC2"
  force_delete        = true

  launch_template {
    id      = aws_launch_template.philoberry_It.id
    version = "$Latest"
  }

  # ... additional configuration ...
}
