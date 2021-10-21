resource "local_file" "bastion_vars" {
  sensitive_content = templatefile("${path.module}/scripts/vars-bastion.yaml.tpl", {
    domain      = aws_route53_zone.osxp.name
    domainlocal = aws_route53_zone.osxp_private.name
    access_key  = aws_iam_access_key.osxp_certbot.id
    secret_key  = aws_iam_access_key.osxp_certbot.secret
  })
  filename        = "${path.module}/ansible-bastion/vars.yaml"
  file_permission = "0600"
}

resource "local_file" "bastion_hosts" {
  sensitive_content = templatefile("${path.module}/scripts/inventory-bastion.tpl", {
    bastion = "${aws_route53_record.osxp_bastion.name}.${aws_route53_zone.osxp.name}"
  })
  filename        = "${path.module}/ansible-bastion/inventory"
  file_permission = "0640"
}

resource "local_file" "awx_vars" {
  sensitive_content = templatefile("${path.module}/scripts/vars-awx.yaml.tpl", {
    domain = aws_route53_zone.osxp.name
    domainlocal = aws_route53_zone.osxp_private.name
    access_key = aws_iam_access_key.osxp_awx_manager.id
    secret_key = aws_iam_access_key.osxp_awx_manager.secret
  })
  filename = "${path.module}/ansible-awx/vars.yaml"
  file_permission = "0600"
}
