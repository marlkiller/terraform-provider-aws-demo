resource "aws_iam_role" "customer_portal_lambda_role" {
  name        = var.lambda_role_name
  description = var.lambda_role_description

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            }
        }
    ]
}
EOF

  tags = var.tags
}
#
#resource "aws_iam_role" "customer_portal_nuke_account_role" {
#  name        = var.nuke_account_role_name
#  description = var.nuke_account_role_description
#
#  assume_role_policy = <<EOF
#{
#    "Version": "2012-10-17",
#    "Statement": [
#        {
#            "Effect": "Allow",
#            "Action": "sts:AssumeRole",
#            "Principal": {
#                "Service": "lambda.amazonaws.com"
#            }
#        }
#    ]
#}
#EOF
#
#  tags = var.tags
#}
#
#resource "aws_iam_role" "customer_portal_api_gateway_role" {
#  name               = var.api_gateway_role_name
#  description        = var.api_gateway_role_description
#  assume_role_policy = <<EOF
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Effect": "Allow",
#      "Action": "sts:AssumeRole",
#      "Principal": {
#        "Service": "apigateway.amazonaws.com"
#      }
#    }
#  ]
#}
#EOF
#
#  tags = var.tags
#}
#
#resource "aws_iam_role" "customer_portal_stepfunction" {
#  name        = var.stepfunction_role_name
#  description = var.stepfunction_role_description
#
#  assume_role_policy = <<EOF
#{
#  "Version": "2012-10-17",
#  "Statement": [
#    {
#      "Effect": "Allow",
#      "Action": "sts:AssumeRole",
#      "Principal": {
#        "Service": "states.amazonaws.com"
#      }
#    }
#  ]
#}
#EOF
#
#  tags = var.tags
#}
