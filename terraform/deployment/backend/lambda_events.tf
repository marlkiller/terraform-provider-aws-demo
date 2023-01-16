locals {
#  update_dynamodb_account_info = templatefile("../../data/event_bridge_rules_inputs/account-information-dynamodb-to-sqs-event-input.json",
#    {
#      queue_url  = module.sqs.queues.traffic-ping-task.id
#      table_name = local.dynamodb_tables["account-information"].id
#    }
#  )
#  update_vpc_info_from_account_info = templatefile("../../data/event_bridge_rules_inputs/account-information-dynamodb-to-sqs-event-input.json",
#    {
#      queue_url  = module.sqs.queues.update-vpc-inventory-from-accounts.id
#      table_name = local.dynamodb_tables["account-information"].id
#    }
#  )
#  update_hosted_zone_info_from_account_info = templatefile("../../data/event_bridge_rules_inputs/account-information-dynamodb-to-sqs-event-input.json",
#    {
#      queue_url  = module.sqs.queues.update-hosted-zone-inventory-from-accounts.id
#      table_name = local.dynamodb_tables["account-information"].id
#    }
#  )
#  update_dynamodb_network_info = templatefile("../../data/event_bridge_rules_inputs/network-details-dynamodb-to-sqs-event-input.json",
#    {
#      queue_url  = module.sqs.queues.vpc-update-distribution.id
#      table_name = local.dynamodb_tables["network-details"].id
#    }
#  )
#  update_dynamodb_hosted_zone_info = templatefile("../../data/event_bridge_rules_inputs/hosted-zone-information-dynamodb-to-sqs-event-input.json",
#    {
#      queue_url  = module.sqs.queues.hosted-zone-update-distribution.id
#      table_name = local.dynamodb_tables["dns-information"].id
#    }
#  )
#  update_dynamodb_security_hub_info = templatefile("../../data/event_bridge_rules_inputs/security-hub-details-dynamodb-to-sqs-event-input.json",
#    {
#      queue_url  = module.sqs.queues.security-hub-update-distribution.id
#      table_name = local.dynamodb_tables["account-information"].id
#    }
#  )
#  update_dynamodb_idp_info = templatefile("../../data/event_bridge_rules_inputs/idp-information-dynamodb-to-sqs-event-input.json",
#    {
#      queue_url  = module.sqs.queues.idp-update-distribution.id
#      table_name = local.dynamodb_tables["account-information"].id
#    }
#  )
#  update_dynamodb_account_principals = templatefile("../../data/event_bridge_rules_inputs/principals-information-dynamodb-to-sqs-event-input.json",
#    {
#      queue_url  = module.sqs.queues.account-principals-update-distribution.id
#      table_name = local.dynamodb_tables["account-information"].id
#    }
#  )
#  update_unused_iam_user_credentials = templatefile("../../data/event_bridge_rules_inputs/unused-iam-credentials-dynamodb-to-sqs-event-input.json",
#    {
#      queue_url  = module.sqs.queues.unused-iam-credentials-distribution.id
#      table_name = local.dynamodb_tables["account-information"].id
#    }
#  )
}

module "events" {
  source = "../../modules/lambda_events"

  prefix = var.prefix
  tags   = var.tags

  cloudwatch_rules_specs = {
    traffic-schedule = {
      description         = "Check all AWS Accounts in Stage 'basic' for a valid APP-Id and LSV/Planpositionnumber. Notifies the Account Responsibles before the Account gets suspended"
#      schedule_expression = "cron(0 23 * * ? *)"
#      schedule_expression = "rate(5 minutes)"
      schedule_expression = "rate(1 minute)"
      lambda_key          = "ping-task-dev"
      input               = "{}"
      is_enabled          = var.enable_cloudwatch_rules
    }
#    check-free-cidrs = {
#      description         = "Check against DynamoDB how many free reserved CIDR ranges are available for Private VPCs"
#      schedule_expression = var.prefix == "prod" ? "cron(0 6 ? * MON-FRI *)" : "cron(0 5 ? * MON *)"
#      lambda_key          = "check-cidr-ranges"
#      input               = "{}"
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    check-sbus-data = {
#      description         = "Check against DynamoDB for items with missing SBUS data"
#      schedule_expression = "cron(0 23 * * ? *)"
#      lambda_key          = "check-sbus-data"
#      input               = "{}"
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    check-dead-letter-queues = {
#      description         = "Check for the messages in the dead-letter-queues"
#      schedule_expression = "cron(0 0 * * ? *)"
#      lambda_key          = "check-dead-letter-queues"
#      input               = "{}"
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    check-manual-pending-orders = {
#      description         = "Check against DynamoDB how many pending orders are unapproved at the moment"
#      schedule_expression = "cron(0 9,14 ? * MON-FRI *)"
#      lambda_key          = "check-manual-pending-orders"
#      input               = "{}"
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    check-training-status = {
#      description         = "Check upcoming and completed trainings for preparation or cleanup tasks"
#      schedule_expression = "cron(0 3 ? * * *)"
#      lambda_key          = "check-training-status"
#      input               = "{}"
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    populate-account-stats = {
#      description         = "Populates the statistics database with accounts information"
#      schedule_expression = "cron(0 23 * * ? *)"
#      lambda_key          = "populate-account-stats"
#      input               = "{}"
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    populate-order-stats = {
#      description         = "Populates the statistics database with orders information"
#      schedule_expression = "cron(0 23 * * ? *)"
#      lambda_key          = "populate-order-stats"
#      input               = "{}"
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    populate-network-stats = {
#      description         = "Populates the statistics database with networks information"
#      schedule_expression = "cron(0 23 * * ? *)"
#      lambda_key          = "populate-network-stats"
#      input               = "{}"
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-dynamodb-account-info = {
#      description         = "get all records from a given dynamodb table with given attributes and create sqs messages for each single record"
#      schedule_expression = "cron(0 2 ? * 1 *)"
#      lambda_key          = "dynamodb-to-sqs"
#      input               = local.update_dynamodb_account_info
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-hosted-zone-info-from-account-info = {
#      description         = "get all records from a given dynamodb table with given attributes and create sqs messages for each single record"
#      schedule_expression = "cron(0 1 ? * 1 *)"
#      lambda_key          = "dynamodb-to-sqs"
#      input               = local.update_hosted_zone_info_from_account_info
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-vpc-info-from-account-info = {
#      description         = "get all records from a given dynamodb table with given attributes and create sqs messages for each single record"
#      schedule_expression = "cron(0 2 ? * 1 *)"
#      lambda_key          = "dynamodb-to-sqs"
#      input               = local.update_vpc_info_from_account_info
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-dynamodb-account-principals = {
#      description         = "get all records from a given dynamodb table with given attributes and create sqs messages for each single record"
#      schedule_expression = "cron(0/30 * ? * * *)"
#      lambda_key          = "dynamodb-to-sqs"
#      input               = local.update_dynamodb_account_principals
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-dynamodb-network-info = {
#      description         = "get all records from a given dynamodb table with given attributes and create sqs messages for each single record"
#      schedule_expression = "cron(0 4/6 ? * * *)"
#      lambda_key          = "dynamodb-to-sqs"
#      input               = local.update_dynamodb_network_info
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-dynamodb-hosted-zone-info = {
#      description         = "get all records from a given dynamodb table with given attributes and create sqs messages for each single record"
#      schedule_expression = "cron(15 4/6 ? * * *)"
#      lambda_key          = "dynamodb-to-sqs"
#      input               = local.update_dynamodb_hosted_zone_info
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-dynamodb-security-hub-info = {
#      description         = "get all records from a given dynamodb table with given attributes and create sqs messages for each single record"
#      schedule_expression = "cron(15 4/6 ? * * *)"
#      lambda_key          = "dynamodb-to-sqs"
#      input               = local.update_dynamodb_security_hub_info
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-dynamodb-idp-info = {
#      description         = "get all records from a given dynamodb table with given attributes and create sqs messages for each single record"
#      schedule_expression = "cron(15 4/6 ? * * *)"
#      lambda_key          = "dynamodb-to-sqs"
#      input               = local.update_dynamodb_idp_info
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-unused-iam-user-credentials = {
#      description         = "get all records from a given dynamodb table with given attributes and create sqs messages for each single record"
#      schedule_expression = "cron(0 9 * * ? *)"
#      lambda_key          = "dynamodb-to-sqs"
#      input               = local.update_unused_iam_user_credentials
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-dynamodb-ad-groups = {
#      description         = "search for active directory groups based on a configuration and write all groups and group members into dynamodb table user-idp-groups"
#      schedule_expression = "rate(20 minutes)"
#      lambda_key          = "idp-list-ad-groups"
#      input               = "{}"
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-portal-permissions = {
#      description         = "update the portal permissions based on the ADGR Group information."
#      schedule_expression = "rate(30 minutes)"
#      lambda_key          = "update-portal-permissions"
#      input               = "{}"
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-dynamodb-account-details-organizations = {
#      description         = "list all accounts from all organizations and update the account information in dynamodb table account-information"
#      schedule_expression = "cron(0 4/6 ? * * *)"
#      lambda_key          = "update-account-details-organizations"
#      input               = "{}"
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-dynamodb-api-key-info = {
#      description         = "look in all the api keys config contained in the portal config and create/update/mark for deletion the record in the api-key-information dynamodb table"
#      schedule_expression = "rate(30 minutes)"
#      lambda_key          = "update-api-key-db"
#      input               = "{}"
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-dynamodb-billing-info = {
#      description         = "Collect AWS Costs from all Master Accounts via Lambda and DynamoDB"
#      schedule_expression = "cron(0 5 * * ? *)"
#      lambda_key          = "update-billing-db"
#      input               = "{}"
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-dynamodb-dx-gateway-info = {
#      description         = "list all direct connect gateways and update the dx gateway information in dynamodb table network-details"
#      schedule_expression = "rate(15 minutes)"
#      lambda_key          = "update-dx-gw-db"
#      input               = "{}"
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    check-free-dx-gateway-associations = {
#      description         = "check the currently available dx gateway associations and create an itsm ticket if the associations felt under a threshold"
#      schedule_expression = "cron(0 6 ? * MON-FRI *)"
#      lambda_key          = "update-dx-gw-db"
#      input               = jsonencode({ "notify" : true })
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-dynamodb-idp-user-info = {
#      description         = "look into an active directory group for member user accounts and write them to dynamodb table user-idp-information"
#      schedule_expression = "rate(20 minutes)"
#      lambda_key          = "update-idp-user-db"
#      input               = "{}"
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-dynamodb-organizations-details = {
#      description         = "list all OUs and SCPs in all available AWS master accounts and writes the result into DynamoDB portal-settings / organizations_details"
#      schedule_expression = "rate(1 hour)"
#      lambda_key          = "update-organizations-settings"
#      input               = "{}"
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-contact-dls = {
#      description         = "create new distribution list for new account if there are not enough already"
#      schedule_expression = "cron(0 6 ? * * *)"
#      lambda_key          = "update-contact-dls"
#      input               = "{}"
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#    update-cdh-permissions = {
#      description         = "Update the account-principals with the CDH informations fetched from their CDH User API"
#      schedule_expression = "rate(23 hours)"
#      lambda_key          = "update-cdh-account-principals-worker"
#      input               = jsonencode({ "update_type" : "bulk" })
#      is_enabled          = var.enable_cloudwatch_rules
#    }
  }
  lambda_map_keys_to_arns = {
    for key, lambda_function in module.lambda_functions.functions : key => lambda_function.arn
  }
}
