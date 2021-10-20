output "debug_awx" {
  value = templatefile("${path.module}/scripts/awx.yaml.tpl", {
    pubkey  = file("${path.module}/awx.key.pub")
    name    = "awx"
    project = var.project
    domain  = var.domain
  })
}

output "certbot_accesskey" {
  value = aws_iam_access_key.osxp_certbot.id
}

output "certbot_secretkey" {
  value = aws_iam_access_key.osxp_certbot.secret
  sensitive = true
}
