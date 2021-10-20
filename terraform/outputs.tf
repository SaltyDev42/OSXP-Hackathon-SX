output "debug_bastion" {
  value =  templatefile("${path.module}/scripts/bastion.yaml.tpl", {
    pubkey   = file("${path.module}/bastion.key.pub")
    privkey  = filebase64("${path.module}/awx.key")
    name     = "bastion"
    project  = var.project
    domain   = var.domain
  })
}

output "debug_awx" {
  value =  templatefile("${path.module}/scripts/awx.yaml.tpl", {
    pubkey  = file("${path.module}/awx.key.pub")
    name    = "awx"
    project = var.project
    domain  = var.domain
  })
}
