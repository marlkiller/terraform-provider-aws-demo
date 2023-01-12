#resource "aws_dynamodb_table_item" "lambda_functions" {
#  table_name = local.portal_configuration_table.id
#  hash_key   = local.portal_configuration_table.hash_key
#
#  item = <<ITEM
#    {
#      "${local.portal_configuration_table.hash_key}": { "S": "lambda_functions" },
#      "settings": ${jsonencode(local.lambda_details)}
#    }
#  ITEM
#}

#resource "aws_dynamodb_table_item" "sqs_updates" {
#  table_name = local.portal_configuration_table.id
#  hash_key   = local.portal_configuration_table.hash_key
#
#  item = <<ITEM
#    {
#      "${local.portal_configuration_table.hash_key}": { "S": "sqs_updates" },
#      "settings": ${jsonencode(local.sqs_updates_details)}
#    }
#  ITEM
#}

#resource "aws_dynamodb_table_item" "grant_purchase_role" {
#  table_name = local.portal_configuration_table.id
#  hash_key   = local.portal_configuration_table.hash_key
#
#  item = <<ITEM
#    {
#      "${local.portal_configuration_table.hash_key}": { "S": "grant_purchase_role" },
#      "settings": ${jsonencode(local.grant_purchase_role_configuration)}
#    }
#  ITEM
#}

#resource "aws_dynamodb_table_item" "network_test" {
#  table_name = local.portal_configuration_table.id
#  hash_key   = local.portal_configuration_table.hash_key
#
#  item = <<ITEM
#    {
#      "${local.portal_configuration_table.hash_key}": { "S": "network_test" },
#      "settings": ${jsonencode(local.network_test_configuration)}
#    }
#  ITEM
#}
