variable "prefix" {
  type        = string
  description = "A prefix which will be used for some resources. This value must be unique per AWS account per region."
}

variable "tags" {
  type        = map(string)
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
}

variable "sqs_queue_specs" {
  type = map(object({
    lambda_role_arn            = string
    visibility_timeout_seconds = number
    message_retention_seconds  = number
    delay_seconds              = number
    receive_wait_time_seconds  = number
    redrive_policy = object({
      dead_letter_target_arn = string
      max_receive_count      = number
    })
  }))
}
