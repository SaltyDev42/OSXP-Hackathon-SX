resource "aws_internet_gateway" "osxp" {
  vpc_id = aws_vpc.osxp.id
}

resource "aws_route_table" "osxp" {
  vpc_id = aws_vpc.osxp.id

  route {
    cidr_block = "0.0.0.0/0" ## destination
    gateway_id = aws_internet_gateway.osxp.id
  }

  tags = {
    Name  = "${var.project}-route"
    owner = var.project
  }
}

resource "aws_route_table_association" "osxp" {
  subnet_id      = aws_subnet.osxp.id
  route_table_id = aws_route_table.osxp.id
}
