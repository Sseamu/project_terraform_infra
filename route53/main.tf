
# Route 53 호스팅 영역 생성
resource "aws_route53_zone" "philoberry_com" {
  name = var.domain_name
}
# Route 53 CNAME 레코드 생성
resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.philoberry_com.zone_id
  name    = var.record_name
  type    = "CNAME"
  ttl     = 300
  records = [var.alb_dns_name]
}



