variable "domain_name" {
  description = "Route 53 도메인 이름"
  type        = string
}

variable "record_name" {
  description = "CNAME 레코드 이름"
  type        = string
}

variable "alb_dns_name" {
  description = "ALB의 DNS 이름"
  type        = string
}

