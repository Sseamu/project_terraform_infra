resource "aws_autoscaling_group" "asg" {
  name_prefix         = var.name_prefix
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.vpc_zone_identifier
  target_group_arns   = var.target_group_arns
  health_check_type   = "EC2"
  default_cooldown    = 300
  force_delete        = true

  launch_template {
    id      = var.aws_launch_template_id
    version = "$Latest"
  }
  #   # CloudWatch 및 SNS 설정
  # enabled_metrics = ["GroupInServiceInstances"]
  # termination_policies = ["Default"]
  # lifecycle {
  #   create_before_destroy = true
  # }

  # # SNS 알림 설정 (시작 및 종료 시 주제 알림 전송)
  # notification_configurations {
  #   topic_arn = "arn:aws:sns:us-east-1:123456789012:my-topic"  # SNS 주제 ARN을 지정하세요
  #   notification_type = "autoscaling:EC2_INSTANCE_LAUNCH"
  # }
  # notification_configurations {
  #   topic_arn = "arn:aws:sns:us-east-1:123456789012:my-topic"  # SNS 주제 ARN을 지정하세요
  #   notification_type = "autoscaling:EC2_INSTANCE_TERMINATE"
  # }

  # ... additional configuration ...
}
