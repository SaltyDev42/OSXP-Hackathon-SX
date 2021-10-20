resource "aws_route53_record" "osxp_awx" {
  zone_id = aws_route53_zone.osxp.zone_id
  ttl     = "60"
  type    = "A"
  name    = "awx"
  records = [aws_instance.osxp_awx.public_ip]
}

resource "aws_route53_record" "osxp_bastion" {
  zone_id = aws_route53_zone.osxp.zone_id
  ttl     = "60"
  type    = "A"
  name    = "bastion"
  records = [aws_instance.osxp_bastion.public_ip]
}

resource "aws_route53_record" "osxp_awx_private" {
  zone_id = aws_route53_zone.osxp_private.zone_id
  ttl     = "60"
  type    = "A"
  name    = "awx"
  records = [aws_instance.osxp_awx.private_ip]
}
