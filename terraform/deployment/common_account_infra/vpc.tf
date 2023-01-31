
#resource "aws_vpc" "vpc" {
#  cidr_block = "10.0.0.0/24"
#  enable_dns_hostnames = true
#  enable_dns_support = true
#  tags = {
#    Name = "vpc_name"
#  }
#}

#resource "aws_vpc_endpoint" "ssm_endpoint" {
#  tags                = merge(var.tags, { "Name" = "ssm_endpoint" })
#  vpc_id              = var.vpc_id
#  vpc_id              = aws_vpc.vpc.id
#  service_name        = "com.amazonaws.cn-north-1.ssm"
#  vpc_endpoint_type   = "Interface"
#  security_group_ids  = var.lambda_security_group_ids
#  subnet_ids          = var.lambda_subnet_ids
#  private_dns_enabled = true
#}
#
#resource "aws_vpc_endpoint" "ssm_messages_endpoint" {
#  tags                = merge(var.tags, { "Name" = "ssm_messages_endpoint" })
#  vpc_id              = var.vpc_id
#  service_name        = "com.amazonaws.cn-north-1.ssmmessages"
#  vpc_endpoint_type   = "Interface"
#  security_group_ids  = var.lambda_security_group_ids
#  subnet_ids          = var.lambda_subnet_ids
#  private_dns_enabled = true
#}