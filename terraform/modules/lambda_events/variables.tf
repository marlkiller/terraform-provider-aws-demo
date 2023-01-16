variable "prefix" {
  type        = string
  description = "A prefix which will be used for some resources. This value must be unique per AWS account per region."
}

variable "tags" {
  type        = map(string)
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
}

variable "cloudwatch_rules_specs" {
  type = map(object({
    description         = string
    schedule_expression = string
    lambda_key          = string
    input               = string
    is_enabled          = bool
  }))
  description = <<EOF
    Every key is used to compose the rule name, if environment is defined, it will be applied as prefix

    map(object({
      description         = string - The description of the rule
      schedule_expression = string - The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes)
      lambda_key          = string - The key of the lambda function we want to invoke
      input               = string - The input to pass to the lambda function, leave empty if no input needed
      is_enabled          = bool - Whether the rule should be enabled
    }))
  EOF
}

variable "lambda_map_keys_to_arns" {
  type        = map(string)
  description = "The key value pairs to map the lambda name with the ARN"
}
