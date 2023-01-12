resource "aws_iam_role_policy_attachment" "customer_portal_lambda_policy_attachments" {
  count = length(var.lambda_policy_attachment_arns)

  role       = aws_iam_role.customer_portal_lambda_role.name
  policy_arn = var.lambda_policy_attachment_arns[count.index]
}
#
#resource "aws_iam_role_policy_attachment" "customer_portal_nuke_account_policy_attachments" {
#  count = length(var.nuke_account_policy_attachment_arns)
#
#  role       = aws_iam_role.customer_portal_nuke_account_role.name
#  policy_arn = var.nuke_account_policy_attachment_arns[count.index]
#}
#
#resource "aws_iam_role_policy_attachment" "customer_portal_api_gateway_policy_attachments" {
#  count = length(var.api_gateway_policy_attachment_arns)
#
#  role       = aws_iam_role.customer_portal_api_gateway_role.name
#  policy_arn = var.api_gateway_policy_attachment_arns[count.index]
#}
#
#resource "aws_iam_role_policy_attachment" "customer_portal_step_function_policy_attachments" {
#  count = length(var.stepfunction_policy_attachment_arns)
#
#  role       = aws_iam_role.customer_portal_stepfunction.name
#  policy_arn = var.stepfunction_policy_attachment_arns[count.index]
#}
