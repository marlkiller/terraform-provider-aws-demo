resource "aws_iam_role_policy" "customer_portal_lambda_policy" {
  name   = var.lambda_policy_name
  role   = aws_iam_role.customer_portal_lambda_role.id
  policy = var.lambda_policy
}

#resource "aws_iam_role_policy" "customer_portal_nuke_account_policy" {
#  name   = var.nuke_account_policy_name
#  role   = aws_iam_role.customer_portal_nuke_account_role.id
#  policy = var.nuke_account_policy
#}

# resource "aws_iam_role_policy" "api_gateway" {
#   name   = var.stepfunction_policy_name
#   role   = aws_iam_role.customer_portal_api_gateway_role.id
#   policy = var.api_gateway_policy
# }
