resource "local_file" "ansible_vars" {
  sensitive_content = templatefile("${path.module}/scripts/vars.yaml.tpl", {
    domain = aws_route53_zone.osxp.name
    domainlocal = aws_route53_zone.osxp_private.name
    access_key = aws_iam_access_key.osxp_certbot.id
    secret_key = aws_iam_access_key.osxp_certbot.secret
  })
  filename = "${path.module}/ansible-bastion/vars.yaml"
  file_permission = "0600"
}

resource "local_file" "ansible_hosts" {
  sensitive_content = templatefile("${path.module}/scripts/inventory.tpl", {
    bastion = "${aws_route53_record.osxp_bastion.name}.${aws_route53_zone.osxp.name}"
  })
  filename = "${path.module}/ansible-bastion/inventory"
  file_permission = "0640"
}
