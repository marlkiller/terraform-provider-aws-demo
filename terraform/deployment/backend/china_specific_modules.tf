# if we see the need to implement also global region specific stuff we can do if for global as well

#module "china_lambda_functions" {
#  for_each = lower(local.portal_region) == "china" ? { "${lower(local.portal_region)}" = var.china_region_specific_specs } : {}
#
#  source = "../../modules/lambda_functions"
#
#  prefix = var.prefix
#  tags   = merge(var.tags, { "datadog_monitored" = var.datadog_monitored }, try(each.value.tags, {}))
#
#  max_age_for_dynamo_records_in_sec = var.lambda_max_age_for_dynamo_records_in_sec
#  max_retry_for_dynamo_records      = var.lambda_max_retry_for_dynamo_records
#
#  lambda_functions_specs = {
#    rotate-credentials = {
#      runtime = var.lambda_python_runtime
#      publish = var.lambda_create_versions
#      layers_arns = [
#        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
#        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
#      ]
#      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
#      log_retention_days = var.lambda_log_retention_days
#      description        = "Customer Portal - Rotate IAM user credentials"
#      memory_size        = 128
#      timeout            = 300
#      source_file_path   = "../../../src/backend/rotate_credentials.py"
#      output_file_path   = "../../../build/rotate_credentials.zip"
#      handler            = "rotate_credentials.lambda_handler"
#      environment_variables = {
#        DEBUGGING_LEVEL                 = var.lambda_logging_level
#        PORTAL_SOURCE                   = module.error_events.events_source
#        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
#        DATADOG_SSM_PARAMETER_NAME      = module.china_datadog_param["china"].name
#      }
#      permissions = {
#        cloud_watch_event_monthly = {
#          statement_id = local.lambda_cloud_watch_permission_default_statement_id
#          principal    = local.lambda_cloud_watch_permission_default_principal
#          source_arn   = module.china_events["china"].rules["rotate-credentials"].arn
#        }
#      }
#      event_sources      = {}
#      subnet_ids         = []
#      security_group_ids = []
#    }
#  }
#}

#module "china_events" {
#  for_each = lower(local.portal_region) == "china" ? { "${lower(local.portal_region)}" = var.china_region_specific_specs } : {}
#
#  source = "../../modules/lambda_events"
#
#  prefix = var.prefix
#  tags   = merge(var.tags, try(each.value.tags, {}))
#
#  cloudwatch_rules_specs = {
#    rotate-credentials = {
#      description         = "Check upcoming and completed trainings for preparation or cleanup tasks"
#      schedule_expression = "cron(0 12 ? * 2#1 *)"
#      lambda_key          = "rotate-credentials"
#      input               = file("../../data/event_bridge_rules_inputs/rotate-credentials-info-${lower(local.portal_region)}.json")
#      is_enabled          = var.enable_cloudwatch_rules
#    }
#  }
#  lambda_map_keys_to_arns = {
#    for key, lambda_function in module.china_lambda_functions["china"].functions : key => lambda_function.arn
#  }
#}

#module "china_datadog_param" {
#  for_each = lower(local.portal_region) == "china" ? { "${lower(local.portal_region)}" = var.china_region_specific_specs } : {}
#
#  source = "../../modules/ssm_parameter"
#  tags   = merge(var.tags, try(each.value.tags, {}))
#
#  parameter_name        = "${local.parameter_prefix}${each.value.ssm_parameter_datadog_contract_data}"
#  parameter_description = "Datadog contract data for credential rotation"
#  parameter_value = jsonencode(
#    {
#      "server_variables" : { "site" : "replaceme" },
#      "api_key" : {
#        "apiKeyAuth" : "replaceme",
#        "appKeyAuth" : "replaceme"
#      }
#    }
#  )
#}
