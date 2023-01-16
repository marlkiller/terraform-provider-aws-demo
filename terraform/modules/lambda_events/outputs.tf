output "rules" {
  value = {
    for key, cw_rule in aws_cloudwatch_event_rule.customer_portal_event_rule : key => {
      id  = cw_rule.id
      arn = cw_rule.arn
    }
  }
}
