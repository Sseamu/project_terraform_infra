variable "name_prefix" {
  description = "Prefix for the names of resources created by this module"
}
variable "ami" {
  type    = string
  default = "ami-0f22ac1c12807aefc"
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
