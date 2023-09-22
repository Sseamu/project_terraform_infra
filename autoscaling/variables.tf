
variable "name_prefix" {
  description = "Prefix for asg"
}
variable "desired_capacity" {
  type        = number
  description = "asg_capacity"
}

variable "max_size" {
  type        = number
  description = "asg_max_size"
}

# variable "default_cooldown" {
#   description = "(Optional, Default: 300) Time (in seconds) after a scaling activity completes before another scaling activity can start."
#   type        = number
#   default     = 300
# }

variable "min_size" {
  type        = number
  description = "asg_min_size"
}

variable "instance_type" {
  type = string
}

variable "availability_zone" {
  type = string
}

variable "aws_launch_template_id" {
  type        = string
  description = "aws_launch_template _id"
}

variable "service_type" {
  type = string
}

variable "vpc_zone_identifier" {
  description = "(Optional) A list of subnet IDs to launch resources in."
  type        = list(any)
}
variable "target_group_arns" {
  description = "(Optional) A list of aws_alb_target_group ARNs, for use with Application or Network Load Balancing."
  type        = list(string)
  default     = []
}
variable "load_balancers" {
  description = "(Optional) A list of elastic load balancer names to add to the autoscaling group names. Only valid for classic load balancers. For ALBs, use target_group_arns instead."
  type        = list(string)
  default     = []
}
