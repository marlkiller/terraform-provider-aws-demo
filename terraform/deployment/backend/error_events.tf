module "error_events" {
  source = "../../modules/error_events"

  prefix        = var.prefix
  rule_name     = "forward-backend-errors"
  tags          = var.tags
  events_source = "backend.${var.prefix}.aws.bmw.cloud"
  sns_topic_arn = module.traffic_errors_sns.arn
  is_enabled    = var.enable_cloudwatch_rules
}
