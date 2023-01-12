resource "aws_cloudwatch_event_rule" "error_rule" {
  name        = var.prefix == "" ? var.rule_name : "${var.prefix}-${var.rule_name}"
  description = var.rule_description
  is_enabled  = var.is_enabled
  tags        = var.tags

  event_pattern = jsonencode(
    {
      "source" : [
        var.events_source
      ]
    }
  )
}

resource "aws_cloudwatch_event_target" "errors_to_sns" {
  rule = aws_cloudwatch_event_rule.error_rule.name
  arn  = var.sns_topic_arn
}


data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

resource "aws_cloudwatch_event_target" "errors_to_logs" {
  rule = aws_cloudwatch_event_rule.error_rule.name
  arn  = "arn:aws-cn:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/events/${var.events_source}"
}

resource "aws_cloudwatch_log_group" "error_logs" {
  name              = "/aws/events/${var.events_source}"
  retention_in_days = var.log_retention_days
  tags              = var.tags
}
