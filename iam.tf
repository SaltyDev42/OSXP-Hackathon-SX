resource "aws_iam_user" "osxp_certbot" {
  name = "${var.project}-certbot"
  tags = {
    Name = "${var.project}-certbot"
    TTL = "86400"
    owner = "${var.project}"
    usage = "LetsEncrypt Certbot"
  }
}


resource "aws_iam_access_key" "osxp_certbot" {
  user = aws_iam_user.osxp_certbot.name
}

resource "aws_iam_user_policy" "osxp_certbot_route53" {
  name = "certbot-policy-route53"
  user = aws_iam_user.osxp_certbot.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Id": "certbot-dns-route53 sample policy",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "route53:ListHostedZones",
                "route53:GetChange"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Effect" : "Allow",
            "Action" : [
                "route53:ChangeResourceRecordSets"
            ],
            "Resource" : [
                "${aws_route53_zone.osxp.arn}"
            ]
        }
    ]
}
EOF
}
