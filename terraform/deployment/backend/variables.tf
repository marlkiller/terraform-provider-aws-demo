# General deployment variables

variable "aws_region" {
  type        = string
  default     = "cn-north-1"
  description = "AWS region"
}

variable "lambda_subnet_ids" {
  type        = list(string)
  description = "Subnet ids for Lambda functions wich runs in a VPC"
}

variable "lambda_security_group_ids" {
  type        = list(string)
  description = "Security Group ids for Lambda functions wich runs in a VPC"
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
#
#variable "account_id_portal_region_mapping" {
#  description = "mapping for AWS account and Self Service Portal region"
#  default = {
#    "558715975237" = "Global",
#    "415285557955" = "Global",
#    "397570527492" = "Global",
#    "309366891939" = "China",
#    "543723171637" = "China"
#  }
#}

variable "tags" {
  type        = map(string)
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
}
#
variable "datadog_monitored" {
  type        = bool
  default     = false
  description = "If true, datadog will load metrics and logs from deployed resources"
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

# Lambda Functions
#
variable "lambda_logging_level" {
  type        = string
  default     = "DEBUG"
  description = "Logging level for Lambda functions"
}

variable "lambda_log_retention_days" {
  type        = number
  default     = 30
  description = <<EOF
    Specifies the number of days you want to retain log events in the specific lambda log group.
    Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653
  EOF
}

variable "lambda_python_runtime" {
  type        = string
  default     = "python3.9"
  description = "Identifier of the function's runtime. See https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime for valid values."
}
#
variable "lambda_create_versions" {
  type        = bool
  default     = false
  description = "Publish a new version of Lambda each time the code changes"
}
#
#variable "lambda_trigger_dynamodb_enabled" {
#  type        = bool
#  default     = false
#  description = "Enable or disable DynamoDB as event source for Lambda functions"
#}
#
#variable "dynamodb_set_ttl" {
#  type        = bool
#  default     = false
#  description = "Set the DynamoDB TTL values"
#}
#
variable "lambda_trigger_sqs_enabled" {
  type        = bool
  default     = false
  description = "Enable or disable SQS as event source for Lambda functions"
}

#variable "lambda_api_key_usage_days" {
#  type        = number
#  default     = 7
#  description = "The number of days we want to retrieve the api key usage when we perform the update of the api key table"
#}
#
#variable "lambda_api_key_ttl_days_existing_keys" {
#  type        = number
#  default     = 1
#  description = "The number of days we want to extend the ttl of every item in the api key table if the api key still exist"
#}
#
#variable "lambda_api_key_ttl_days_deleted_keys" {
#  type        = number
#  default     = 30
#  description = "The number of days we want to extend the ttl of every item in the api key table if the api key not exist anymore"
#}
#
variable "lambda_max_age_for_dynamo_records_in_sec" {
  type        = number
  description = "The maximum age of a record that Lambda sends to a function for processing. Only available for stream sources (DynamoDB and Kinesis). Minimum of 60, maximum and default of 604800."
  default     = 604800
}

variable "lambda_max_retry_for_dynamo_records" {
  type        = number
  description = "The maximum number of times to retry when the function returns an error. Only available for stream sources (DynamoDB and Kinesis). Minimum of 0, maximum and default of 10000.(-1)"
  default     = null
}

# CloudWatch Events / EventBridge

variable "enable_cloudwatch_rules" {
  type        = bool
  description = "Enables or disables all CloudWatch Event Rules"
}

# 3rd Party Integrations

#variable "splunk_acc_queue_url" {
#  type        = string
#  default     = null
#  description = "Target SQS Queue URL to send AWS account updates from DynamoDB"
#}
#
#variable "ssm_parameter_itsm_contract_data" {
#  type        = string
#  default     = "itsm.contract.data"
#  description = "SSM Parameter Name which contains ITSM details"
#}
#
#variable "ssm_parameter_sbus_contract_data" {
#  type        = string
#  default     = "sbus.contract.data"
#  description = "SSM Parameter Name which contains SBUS contract details"
#}
#
#variable "ssm_parameter_sbus_token_contract_data" {
#  type        = string
#  default     = "sbus.token.contract.data"
#  description = "SSM Parameter Name which contains SBUS token contract details"
#}
#
#variable "ssm_parameter_tufin_data" {
#  type        = string
#  default     = "tufin.data"
#  description = "SSM Name of the Parameter which contains TUFIN API details"
#}
#
#variable "four_wheels_automation_account_id" {
#  type        = string
#  description = "The AWS account id for the BMW DevOps 4wheels - KAAS - Automation Backend (to send data into our SQS queues)"
#}
#
#variable "ssm_parameter_mailtools_data" {
#  type        = string
#  default     = "mailtools.data"
#  description = "SSM Name of the Parameter which contains MAILTOOLS API details"
#}
#
## Email templates
#variable "email_templates_prefix" {
#  type        = string
#  description = "The prefix and path for email templates within the S3 bucket."
#  default     = ""
#}
#
#variable "email_templates_env" {
#  type        = string
#  description = "Either global or china. Used for local path."
#  default     = ""
#}
#
#variable "portal_resources_bucket_name" {
#  type        = string
#  description = "The name of the portal resources S3 bucket."
#  default     = ""
#}
#
#variable "ssm_parameter_bmw_internal_mail" {
#  type        = string
#  default     = "bmw.internal.mail"
#  description = "SSM Parameter Name which contains smtp connection details"
#}

# Region specific

#variable "china_region_specific_specs" {
#  type = object({
#    ssm_parameter_datadog_contract_data = string
#    tags                                = map(string)
#  })
#  default = {
#    ssm_parameter_datadog_contract_data = "datadog.contract.data"
#    tags = {
#      specific_resource = "yes"
#      portal_region     = "china"
#    }
#  }
#  description = "Dynamic map to introduce vars that are specific to China only"
#}

#variable "deploy_grant_purchase_role" {
#  type    = bool
#  default = false
#}
variable "partition" {
  type    = string
  default = "aws-cn"
}
