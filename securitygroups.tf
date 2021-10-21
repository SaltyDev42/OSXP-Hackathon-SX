resource "aws_security_group" "osxp_bastion" {
  vpc_id      = aws_vpc.osxp.id
  name        = "bastion-sg"
  description = "SSH access"

  ingress {
    description      = "SSH from everyone"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Unrestricted internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name  = "${var.project}-bastion"
    owner = "${var.project}"
  }
}

resource "aws_security_group" "osxp_all" {
  vpc_id      = aws_vpc.osxp.id
  name        = "osxp-unrestricted"
  description = "Unrestricted access"

  ingress {
    description      = "Unrestricted internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    description      = "Unrestricted internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name  = "${var.project}-all"
    owner = "${var.project}"
  }
}

resource "aws_security_group" "osxp_awx" {
  vpc_id      = aws_vpc.osxp.id
  name        = "awx-sg"
  description = "HTTPS from internet, restricted SSH"

  ingress {
    description      = "HTTPS from internet"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description     = "SSH awx from bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.osxp_bastion.id]
  }

  egress {
    description      = "Unrestricted internet"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name  = "${var.project}-awx"
    owner = "${var.project}"
  }
}
