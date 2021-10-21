## Primary Zone
data "aws_route53_zone" "main" {
  name = var.domain
}

## Sub Zone PUBLIC RECORDS
resource "aws_route53_zone" "osxp" {
  name = "${var.project}.${data.aws_route53_zone.main.name}"
  tags = {
    Name  = "${var.project}-zone"
    owner = var.project
  }
}

resource "aws_route53_zone" "osxp_private" {
  name = "${var.project}.${var.domainlocal}"
  vpc {
    vpc_id = aws_vpc.osxp.id
  }

  tags = {
    Name  = "${var.project}-localzone"
    owner = var.project
  }
}

## Delegation
resource "aws_route53_record" "osxp_ns" {
  name    = aws_route53_zone.osxp.name
  ttl     = "60"
  type    = "NS"
  zone_id = data.aws_route53_zone.main.zone_id

  records = [
    aws_route53_zone.osxp.name_servers[0],
    aws_route53_zone.osxp.name_servers[1],
    aws_route53_zone.osxp.name_servers[2],
    aws_route53_zone.osxp.name_servers[3],
  ]
}
