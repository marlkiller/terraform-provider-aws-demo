variable "prefix" {
  type        = string
  description = "A prefix which will be used for some resources. This value must be unique per AWS account per region."
}

variable "tags" {
  type        = map(string)
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
}

variable "rule_name" {
  type        = string
  description = "The rule name associated with the error events"
}

variable "rule_description" {
  type        = string
  description = "Description for CloudWatch/EventBridge Rule"
  default     = "Forwarding of error events from the traffic project."
}

variable "events_source" {
  type        = string
  description = "Event source to identify where the event comes from."
}

variable "sns_topic_arn" {
  type        = string
  description = "SNS topic arn as event target for CloudWatch/EventBridge events."
}

variable "log_retention_days" {
  type        = number
  default     = 180
  description = <<EOF
    Specifies the number of days you want to retain log events in the specific api gateway log group.
    Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, and 3653
  EOF
}

variable "is_enabled" {
  type        = bool
  description = "Enable or disable the CloudWatch Event Rule"
}
