variable "prefix" {
  type        = string
  description = "A prefix which will be used for some resources. This value must be unique per AWS account per region."
}

variable "tags" {
  type        = map(string)
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
}

variable "topic_name" {
  type        = string
  description = "SNS Topic Name"
}
#
#variable "kms_key_id" {
#  type        = string
#  description = "KMS Key Id"
#  default     = "alias/aws/sns"
#}

variable "partition" {
  type    = string
  default = "aws"
}

variable "policies" {
  type = list(string)
}
