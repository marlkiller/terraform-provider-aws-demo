variable "prefix" {
  type        = string
  description = "A prefix which will be used for some resources. This value must be unique per AWS account per region."
}

variable "tags" {
  type        = map(string)
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
}

variable "lambda_functions_specs" {
  type = map(object({
    description           = string
    memory_size           = number
    timeout               = number
    runtime               = string
    publish               = bool
    source_file_path      = string
    output_file_path      = string
    handler               = string
    layers_arns           = list(string)
    role_arn              = string
    log_retention_days    = number
    environment_variables = map(string)
    permissions = map(object({
      statement_id = string
      principal    = string
      source_arn   = string
    }))
    event_sources = map(object({
      enabled           = bool
      filter_criteria   = list(string)
      batch_size        = number
      starting_position = string
      source_arn        = string
    }))

    subnet_ids         = list(string)
    security_group_ids = list(string)
  }))
}

variable "max_age_for_dynamo_records_in_sec" {
  type        = number
  description = "The maximum age of a record that Lambda sends to a function for processing. Only available for stream sources (DynamoDB and Kinesis). Minimum of 60, maximum and default of 604800."
  default     = 604800
}

variable "max_retry_for_dynamo_records" {
  type        = number
  description = "The maximum number of times to retry when the function returns an error. Only available for stream sources (DynamoDB and Kinesis). Minimum of 0, maximum and default of 10000.(-1)"
  default     = null
}
