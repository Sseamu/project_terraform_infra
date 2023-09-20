variable "name_prefix" {
  description = "Prefix for the launchTemplate"
}
variable "ami" {
  type    = string
  default = "ami-0f22ac1c12807aefc"
}
variable "instance_type" {
  type = string
}

variable "key_name" {
  type    = string
  default = "philoberry-keypair"
}


variable "launch_template_description" {
  type        = string
  description = "laucn_template_description"
}

variable "security_group_id" {
  description = "The ID of the ec2 security group"
  type        = string
}
