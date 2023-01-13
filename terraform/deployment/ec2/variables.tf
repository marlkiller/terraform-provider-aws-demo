# General deployment variables

variable "aws_region" {
  type        = string
  default     = "cn-north-1"
  description = "AWS region"
}

variable "aws_profile" {
  type        = string
  description = "AWS profile which is used for the deployment"
}

variable "aws_shared_credentials_file" {
  type        = string
  default     = "~/.aws/credentials"
  description = "Location of the AWS CLI credentials"
}

variable "tags" {
  type        = map(string)
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
}

variable "prefix" {
  type        = string
  description = "A prefix which will be used for some resources. This value must be unique per AWS account per region."
}

# Terraform State Import

variable "import_prefix" {
  type        = string
  description = "The prefix used for the bucket to source information where the tf state file is stored"
}
variable "ec2_subnet_id" {
  type        = string
  description = "The prefix used for the bucket to source information where the tf state file is stored"
}
variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "instance_name" {
  type = string
}
variable "iam_instance_profile" {
  type = string
}

# API Gateway
#variable "api_gateway_role_name" {
#  type        = string
#  description = "Name of IAM role which dictates what other AWS services the API Gateway may access"
#}
#
#variable "api_gateway_role_description" {
#  type        = string
#  default     = "Allows API Gateway to write over CloudWatch"
#  description = "Description of IAM role which dictates what other AWS services the API Gateway may access"
#}

# variable "api_gateway_policy_name" {
#   type        = string
#   default     = "traffic-network-apigateway-policy"
#   description = "Name of IAM policy which dictates what other AWS services the API Gateway may access"
# }

# Lambda Functions

variable "lambda_role_name" {
  type        = string
  description = "Name of IAM role which dictates what other AWS services the Lambda function may access"
}

variable "lambda_role_description" {
  type        = string
  default     = "IAM role for Lambda to execute automation tasks for the AWS Network Monitor - China for AWS"
  description = "Description of IAM role which dictates what other AWS services the Lambda function may access"
}

variable "lambda_policy_name" {
  type        = string
  default     = "customer-traffic-lambda-policy"
  description = "Name of IAM policy which dictates what other AWS services the Lambda function may access"
}

#variable "nuke_account_role_name" {
#  type        = string
#  description = "Name of IAM role which dictates what other AWS services the Lambda function may access"
#}
#
#variable "nuke_account_role_description" {
#  type        = string
#  default     = "IAM role for deletion of all resources in AWS accounts"
#  description = "Description of IAM role which dictates what other AWS services the Lambda function may access"
#}
#
#variable "nuke_account_policy_name" {
#  type        = string
#  default     = "traffic-network-nuke-account-policy"
#  description = "Name of IAM policy which dictates what other AWS services the Lambda function may access"
#}

#variable "ssm_parameter_ad_credentials" {
#  type        = string
#  default     = "ad.credentials"
#  description = "SSM Parameter which contains AD credentials"
#}
#
#variable "four_wheels_automation_account_id" {
#  type        = string
#  description = "The AWS account id for the BMW DevOps 4wheels - KAAS - Automation Backend, needed for `lambda_role_name` policy since SQS on that account is KMS Encrypted"
#}
#
#variable "cdh_api_gateway_region" {
#  type        = string
#  description = "The AWS region where the CDH User API gateway is running"
#  default     = "cn-north-1"
#}
#
#variable "cdh_api_gateway_account_id" {
#  type        = string
#  description = "The AWS account id where the CDH User API gateway is running"
#}
#
## StepFunction
#
#variable "stepfunction_role_name" {
#  type        = string
#  description = "Name of IAM role which dictates what other AWS services the API Gateway may access"
#}
#
#variable "stepfunction_role_description" {
#  type        = string
#  default     = "BMW AWS Network Monitor - China StepFunction"
#  description = "Description of the StepFunction IAM  Role"
#}
#
#variable "stepfunction_policy_name" {
#  type        = string
#  default     = "traffic-network-stepfunction-policy"
#  description = "Description of the StepFunction Policy"
#}
#
## VPC
#
#variable "vpc_id" {
#  type        = string
#  description = "The Id of the VPC contains subnets and sec groups for lambda"
#}
#
## SSM Parameter
#
#variable "cloud_next_parameter_name" {
#  type        = string
#  default     = "cloud.next.api-configuration"
#  description = "Name of the SSM Parameter that points to the configuration needed to contact the Cloud.Next_API"
#}
#
## S3
#
#variable "portal_resources_bucket_name" {
#  type        = string
#  description = "The name of the portal resources S3 bucket."
#}

#WAF - Log configuration

#variable "waf_api_gateway_web_acl_name" {
#  type        = string
#  default     = ""
#  description = "The name of MANAGE WEB ACL to be associated with all the API Gateways used for the portal"
#}
#
#variable "waf_cloudfront_web_acl_name" {
#  type        = string
#  default     = ""
#  description = "The name of MANAGE WEB ACL to be associated with all the Cloudfront used for the portal, region GLOBAL"
#}
#
#variable "waf_s3_logging_bucket_arn" {
#  type        = string
#  default     = ""
#  description = "ARN of s3 bucket from central logging account for waf"
#}

# OpenSearch

#variable "deploy_open_search" {
#  type    = bool
#  default = false
#}
#
#variable "open_search_specs" {
#  type = object({
#    cluster_version      = string
#    cluster_name         = string
#    kms_alias_name       = string
#    identify_pool_suffix = string
#  })
#  default = {
#    cluster_version      = "1.3"
#    cluster_name         = "traffic-network"
#    identify_pool_suffix = "federated"
#    kms_alias_name       = "open-search"
#  }
#}

# in this way we can set different specs for the different env (dev, prod, int, prod-cn etc..)
# e.g.
# in dev we may need bigger ebs but smaller instance type,
# in prod maybe we need more performant instance but not that much space,
# in prod-cn we may use smaller instance and smaller ebs
# etc...
# I would even remove the default from here as soon we enable it in every env
#variable "open_search_cluster_options" {
#  type = object({
#    instance_type  = string
#    instance_count = number
#    ebs_options    = map(any)
#  })
#  default = {
#    instance_type  = "t3.medium.search"
#    instance_count = 1
#    ebs_options = {
#      "ebs_enabled" = true
#      "volume_size" = 10
#      "volume_type" = "gp2"
#    }
#  }
#}
