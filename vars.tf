variable "domain" {
  type = string
}

variable "project" {
  type    = string
  default = "osxp"
}

variable "domainlocal" {
  type = string
}

variable "region" {
  type = string
  default = "eu-west-3"
}

variable "ec2_type" {
  type = string
  default = "t2.small"
}

variable "ami_owner" {
  type = string
}

variable "ami_name" {
  type = string
}
