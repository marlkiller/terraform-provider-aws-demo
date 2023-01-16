resource "aws_ssm_parameter" "param" {
  # TODO - should we use a foreach here as well with the prefix condition?
  # in this was with one module we can deply multiple ssm params
  name        = var.parameter_name
  description = var.parameter_description
  type        = var.parameter_type
  value       = var.parameter_value

  lifecycle {
    ignore_changes = [
      value
    ]
  }

  tags = var.tags
}
