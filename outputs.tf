output "certbot_accesskey" {
  value = aws_iam_access_key.osxp_certbot.id
}

output "certbot_secretkey" {
  value = aws_iam_access_key.osxp_certbot.secret
  sensitive = true
}

output "awx_url" {
  value = "https://${aws_route53_record.osxp_awx.name}.${aws_route53_zone.osxp.name}"
}

output "bastion_fqdn" {
  value = "${aws_route53_record.osxp_bastion.name}.${aws_route53_zone.osxp.name}"
}
