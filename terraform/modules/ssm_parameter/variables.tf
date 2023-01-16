variable "parameter_name" {
  type        = string
  description = "SSM Parameter name"
}

variable "parameter_description" {
  type = string
}

variable "parameter_type" {
  type    = string
  default = "SecureString"
}

variable "parameter_value" {
  type = string
}

variable "tags" {
  type        = map(string)
  description = "The key value pairs we want to apply as tags to the resources contained in this module"
}
