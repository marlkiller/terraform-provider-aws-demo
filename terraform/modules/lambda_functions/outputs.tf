output "functions" {
  value = {
    for key, lambda_function in aws_lambda_function.functions : key => {
      id            = lambda_function.id,
      function_name = lambda_function.function_name,
      version       = lambda_function.version
      arn           = lambda_function.arn
      invoke_arn    = lambda_function.invoke_arn
    }
  }
}
