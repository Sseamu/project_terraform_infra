variable "alb_sg_port" {
  type    = list(number)
  default = [80, 443]
}

#default vpc
variable "vpc_id"{
    type = string
}

#서비스 타입
variable "service_type" {
    type = string
}

#서브넷
variable "subnet_ids" {
    type = list(any)
}