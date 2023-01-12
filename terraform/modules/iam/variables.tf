variable "aws_region" {
  type        = string
  default     = "cn-north-1"
  description = "AWS region"
}

variable "tags" {
  type        = map(string)
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
}

variable "lambda_role_name" {
  type        = string
  description = "Name of IAM role which dictates what other AWS services the Lambda function may access"
}

variable "lambda_role_description" {
  type        = string
  description = "Description of IAM role which dictates what other AWS services the Lambda function may access"
}

variable "lambda_policy_name" {
  type        = string
  description = "Name of IAM policy which dictates what other AWS services the Lambda function may access"
}

variable "lambda_policy" {
  type        = string
  description = "The IAM policy document which dictates what other AWS services the Lambda function may access"
}

variable "lambda_policy_attachment_arns" {
  type        = list(string)
  default     = []
  description = "The list of the policy arn needs to be attached to the lambda role"
}
#
#variable "nuke_account_role_name" {
#  type        = string
#  description = "Name of IAM role which dictates what other AWS services the Lambda function may access"
#}
#
#variable "nuke_account_role_description" {
#  type        = string
#  description = "Description of IAM role which dictates what other AWS services the Lambda function may access"
#}
#
#variable "nuke_account_policy_name" {
#  type        = string
#  description = "Name of IAM policy which dictates what other AWS services the Lambda function may access"
#}
#
#variable "nuke_account_policy" {
#  type        = string
#  description = "The IAM policy document which dictates what other AWS services the Lambda function may access"
#}
#
#variable "nuke_account_policy_attachment_arns" {
#  type        = list(string)
#  default     = []
#  description = "The list of the policy arn needs to be attached to the lambda role"
#}
#
#variable "api_gateway_role_name" {
#  type        = string
#  description = "Name of IAM role which dictates what other AWS services the API Gateway may access"
#}
#
#variable "api_gateway_role_description" {
#  type        = string
#  description = "Description of IAM role which dictates what other AWS services the API Gateway may access"
#}

# disabled in order to avoid the annoying count condition, we can re-introduce if we prefer
# variable "api_gateway_policy_name" {
#   type        = string
#   description = "Name of IAM policy which dictates what other AWS services the API Gateway may access"
# }

# variable "api_gateway_policy" {
#   type        = string
#   description = "The IAM policy document which dictates what other AWS services the API Gateway may access"
# }
#
#variable "api_gateway_policy_attachment_arns" {
#  type        = list(string)
#  default     = []
#  description = "The list of the policy arn needs to be attached to the API Gateway role"
#}
#
#variable "stepfunction_role_name" {
#  type        = string
#  description = "Name of IAM role for AWS StepFunctions"
#}
#
#variable "stepfunction_role_description" {
#  type        = string
#  description = "Description of IAM role for AWS StepFunctions"
#}
#
#variable "stepfunction_policy_name" {
#  type        = string
#  description = "Name of IAM policy for AWS StepFunctions"
#}
#
#variable "stepfunction_policy" {
#  type        = string
#  description = "The IAM policy document which dictates what other AWS services the Step Function may access"
#}
#
#variable "stepfunction_policy_attachment_arns" {
#  type        = list(string)
#  default     = []
#  description = "The list of the policy arn needs to be attached to the step function role"
#}
