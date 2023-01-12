output "lambda_role" {
  value = {
    id  = aws_iam_role.customer_portal_lambda_role.id
    arn = aws_iam_role.customer_portal_lambda_role.arn
  }
}


