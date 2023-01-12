data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
#
#data "aws_vpc" "portal" {
#  id = var.vpc_id
#}
#data "aws_subnets" "lambda" {
#  filter {
#    name   = "vpc-id"
#    values = [var.vpc_id]
#  }
#}
#
#data "aws_network_acls" "portal" {
#  vpc_id = var.vpc_id
#}
