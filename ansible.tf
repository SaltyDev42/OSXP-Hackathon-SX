resource "local_file" "foo" {
  sensitive_content = templatefile("${path.module}/scripts/vars.yaml.tpl", {
    domain = aws_route53_zone.osxp.name
    domainlocal = aws_route53_zone.osxp_private.name
    access_key = aws_iam_access_key.osxp_certbot.id
    secret_key = aws_iam_access_key.osxp_certbot.secret
  })
  filename = "${path.module}/ansible-bastion/vars.yaml"
  file_permission = "0600"
}
