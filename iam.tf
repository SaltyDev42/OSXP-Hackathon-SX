resource "aws_iam_user" "osxp_certbot" {
  name = "${var.project}-certbot"
  tags = {
    Name  = "${var.project}-certbot"
    TTL   = "86400"
    owner = var.project
    usage = "LetsEncrypt Certbot"
  }
}

resource "aws_iam_user" "osxp_awx_manager" {
  name = "${var.project}-awx-manager"
  tags = {
    Name  = "${var.project}-awx-manager"
    TTL   = "86400"
    owner = var.project
    usage = "Managed by Terraform. Used by AWX to create instance"
  }
}

resource "aws_iam_access_key" "osxp_awx_manager" {
  user = aws_iam_user.osxp_awx_manager.name
}

resource "aws_iam_access_key" "osxp_certbot" {
  user = aws_iam_user.osxp_certbot.name
}

resource "aws_iam_user_policy" "osxp_awx_manager" {
  name = "osxp-awx-manager"
  user = aws_iam_user.osxp_awx_manager.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Id": "AWX-manager policy",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:TerminateInstances",
                "ec2:CreateTags",
                "ec2:RunInstances"
            ],
            "Resource": "arn:aws:ec2:eu-west-3::*"
        },
        {
            "Effect": "Allow",
            "Action": [
                "route53:GetChange",
                "route53:GetHostedZone"
            ],
            "Resource": "*"
        },
        {
            "Effect" : "Allow",
            "Action" : [
                "route53:ChangeResourceRecordSets"
            ],
            "Resource" : [
                "${aws_route53_zone.osxp.arn}"
            ]
        },
        {
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeSubnets",
                "ec2:DescribeSecurityGroups"
            ],
            "Resource": "arn:aws:ec2:eu-west-3::*"
        }
    ]
}
EOF
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
