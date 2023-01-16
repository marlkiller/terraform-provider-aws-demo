resource "aws_cloudwatch_event_rule" "customer_portal_event_rule" {
  for_each = var.cloudwatch_rules_specs

  name                = var.prefix == "" ? each.key : "${var.prefix}-${each.key}"
  description         = each.value["description"]
  schedule_expression = each.value["schedule_expression"]
  is_enabled          = each.value["is_enabled"]

  tags = var.tags
}

resource "aws_cloudwatch_event_target" "customer_portal_event_target" {
  for_each = var.cloudwatch_rules_specs

  rule  = aws_cloudwatch_event_rule.customer_portal_event_rule[each.key].name
  arn   = var.lambda_map_keys_to_arns[each.value["lambda_key"]]
  input = lookup(each.value, "input", "") == "" ? null : each.value["input"]
}
