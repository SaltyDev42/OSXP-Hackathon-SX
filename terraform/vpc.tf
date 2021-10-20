resource "aws_vpc" "osxp" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name  = "${var.project}-vpc"
    owner = var.project
  }
}
