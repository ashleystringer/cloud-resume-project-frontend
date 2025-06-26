// ***** NOT COMPLETE YET *****

/*
resource "aws_route53_zone" "primary" {
  name = "ash-stringer-resume-project.com"
}
resource "aws_route53_record" "cdn_a" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "cdn.ash-stringer-resume-project.com"
  type    = "A"
  ttl     = 300
  records = [aws_eip.lb.public_ip]
}
resource "aws_route53_record" "cdn_aaaa" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = "cdn.ash-stringer-resume-project.com"
  type    = "AAAA"
  ttl     = 300
  records = [aws_eip.lb.public_ip]
}
//CNAME RECORD
*/