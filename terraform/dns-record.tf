resource "aws_route53_record" "osxp_awx" {
  zone_id = aws_route53_zone.osxp.zone_id
  ttl     = "60"
  type    = "A"
  name    = "awx.${aws_route53_zone.osxp.name}"
  records = [aws_instance.osxp_awx.public_ip]
}

resource "aws_route53_record" "osxp_awx_task" {
  zone_id = aws_route53_zone.osxp.zone_id
  ttl     = "60"
  type    = "CNAME"
  name    = "awx-task.${aws_route53_zone.osxp.name}"
  records = [aws_route53_record.osxp_awx.name]
}

resource "aws_route53_record" "osxp_bastion" {
  zone_id = aws_route53_zone.osxp.zone_id
  ttl     = "60"
  type    = "A"
  name    = "bastion.${aws_route53_zone.osxp.name}"
  records = [aws_instance.osxp_bastion.public_ip]
}

resource "aws_route53_record" "osxp_awx_private" {
  zone_id = aws_route53_zone.osxp.zone_id
  ttl     = "600"
  type    = "A"
  name    = "awx-local.${aws_route53_zone.osxp.name}"
  record  = [aws_instance.osxp_bastion.private_ip]
}
