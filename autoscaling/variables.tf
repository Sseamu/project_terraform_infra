
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
