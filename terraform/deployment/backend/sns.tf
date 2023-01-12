locals {
  policies = {
    event_bridge_policy = templatefile("../../data/policies/event_bridge_policy.json", {
      account_id = data.aws_caller_identity.current.account_id
      }
    )
    sns_topic_default_policy = templatefile("../../data/policies/traffic_action_sns_policy.json", {
      account_id = data.aws_caller_identity.current.account_id
      }
    )
#    cdh_cross_account_subscriptions = templatefile("../../data/policies/sns_subscription_cross_account_policy.json", {
#      principals = local.cdh_cross_account_subscriptions["aws"]
#      }
#    )
  }
#  cdh_cross_account_subscriptions = {
#    "aws"    = jsonencode(["690779585828", "005021069310"])
#    "aws-cn" = jsonencode(["115888370350", "220254894522"])
#  }
}

module "traffic_action_sns" {
  source = "../../modules/sns"

  prefix     = var.prefix
  topic_name = "traffic_action"
  tags       = var.tags
  policies   = [local.policies.sns_topic_default_policy]
}

module "traffic_errors_sns" {
  source = "../../modules/sns"

  prefix     = var.prefix
  topic_name = "backend-error"
  tags       = var.tags
  policies   = [local.policies.sns_topic_default_policy, local.policies.event_bridge_policy]
}

#module "cdh_notification_sns" {
#  source = "../../modules/sns"
#
#  prefix     = var.prefix
#  topic_name = "cdh-notification-sns"
#  tags       = var.tags
#  policies   = [local.policies.sns_topic_default_policy, local.policies.cdh_cross_account_subscriptions]
#}
