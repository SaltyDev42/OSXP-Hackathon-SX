## Image Rocky Linux, Multiple image available, normal is used
data "aws_ami" "image" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["Rocky Linux 8.4-*"]
  }
}

resource "aws_instance" "osxp_bastion" {
  ami                    = data.aws_ami.image.image_id
  instance_type          = "t2.small"
  subnet_id              = aws_subnet.osxp.id
  vpc_security_group_ids = [aws_security_group.osxp_bastion.id]

  associate_public_ip_address = true
  user_data = templatefile("${path.module}/scripts/bastion.yaml.tpl", {
    pubkey   = file("${path.module}/bastion.key.pub")
    privkey  = filebase64("${path.module}/awx.key")
    name     = "bastion"
    project  = var.project
    domain   = var.domain
  })

  tags = {
    Name  = "${var.project}-bastion"
    TTL   = "86400"
    owner = var.project
  }
}

resource "aws_instance" "osxp_awx" {
  ami                    = data.aws_ami.image.image_id
  instance_type          = "t2.xlarge"
  subnet_id              = aws_subnet.osxp.id
  vpc_security_group_ids = [aws_security_group.osxp_awx.id]

  associate_public_ip_address = true
  user_data = templatefile("${path.module}/scripts/awx.yaml.tpl", {
    pubkey  = file("${path.module}/awx.key.pub")
    name    = "awx"
    project = var.project
    domain  = var.domain
  })

  tags = {
    Name  = "${var.project}-awx"
    TTL   = "86400"
    owner = var.project
  }

  depends_on = [aws_internet_gateway.osxp]
}
