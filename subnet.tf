resource "aws_subnet" "osxp" {
  vpc_id            = aws_vpc.osxp.id
  cidr_block        = "10.0.0.0/18"
  availability_zone = "eu-west-3a"

  tags = {
    Name  = "${var.project}-subnet"
    owner = var.project
  }
}
