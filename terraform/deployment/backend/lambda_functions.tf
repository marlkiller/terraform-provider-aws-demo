module "lambda_functions" {
  source                            = "../../modules/lambda_functions"
  #
  prefix                            = var.prefix
  tags                              = merge(var.tags, { "datadog_monitored" = var.datadog_monitored })
  #
  max_age_for_dynamo_records_in_sec = var.lambda_max_age_for_dynamo_records_in_sec
  max_retry_for_dynamo_records      = var.lambda_max_retry_for_dynamo_records
  #
  lambda_functions_specs            = {
    #    # LAMBDA INVOKED FUNCTIONS
    #    api-key-mgmt = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Create, list and delete API Keys"
    #      memory_size        = 128
    #      timeout            = 15
    #      source_file_path   = "../../../src/backend/order_handlers/api_key_mgmt.py"
    #      output_file_path   = "../../../build/api_key_mgmt.zip"
    #      handler            = "api_key_mgmt.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions        = {}
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    associate-r53r-rules = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Associate Route 53 Resolver Rules to VPC"
    #      memory_size        = 256
    #      timeout            = 120
    #      source_file_path   = "../../../src/backend/order_handlers/associate_r53r_rules.py"
    #      output_file_path   = "../../../build/associate_r53r_rules.zip"
    #      handler            = "associate_r53r_rules.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions        = {}
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    nuke-account = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["aws-nuke-layer"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.nuke_account_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Delete all resources in AWS account"
    #      memory_size        = 1024
    #      timeout            = 900
    #      source_file_path   = "../../../src/backend/order_handlers/nuke_account.py"
    #      output_file_path   = "../../../build/nuke_account.zip"
    #      handler            = "nuke_account.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions        = {}
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    dns-mgmt = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Manage Route53 Private Hosted Zones"
    #      memory_size        = 512
    #      timeout            = 180
    #      source_file_path   = "../../../src/backend/order_handlers/dns_mgmt.py"
    #      output_file_path   = "../../../build/dns_mgmt.zip"
    #      handler            = "dns_mgmt.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #        DNS_UPDATE_QUEUE_URL            = module.sqs.queues.hosted-zone-update-distribution.id
    #      }
    #      permissions        = {}
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    ping-task-dev = {
      runtime     = var.lambda_python_runtime
      publish     = var.lambda_create_versions
      layers_arns = [
        #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
        #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
      ]
      role_arn              = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
      log_retention_days    = var.lambda_log_retention_days
      description           = "Customer Portal - Function that can be invoked to create orders"
      memory_size           = 128
      timeout               = 60
      source_file_path      = "../../../src/ping_task_dev.py"
      output_file_path      = "../../../build/ping_task_dev.zip"
      handler               = "ping_task_dev.lambda_handler"
      environment_variables = {
        DEBUGGING_LEVEL = var.lambda_logging_level
        PORTAL_SOURCE   = module.error_events.events_source
        TRAFFIC_CONFIG  = module.traffic_config_param.name
        SNS_TOPIC_ARN   = module.traffic_action_sns.arn
        SQS_TOPIC_ARN   = module.sqs.queues.traffic-ping-task.arn
        #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
      }

      permissions = {
        cloud_watch_event_every_1_mins = {
          statement_id = local.lambda_cloud_watch_permission_default_statement_id
          principal    = local.lambda_cloud_watch_permission_default_principal
          source_arn   = module.events.rules["traffic-schedule"].arn
        }
      }
      event_sources      = {}
      #      event_sources = {
      #                sqs = {
      #                  enabled           = var.lambda_trigger_sqs_enabled
      #                  filter_criteria   = null
      #                  batch_size        = 1
      #                  starting_position = null
      #                  source_arn        = module.sqs.queues.traffic-ping-task.arn
      #                }
      #      }
      #      subnet_ids         = []
      #      security_group_ids = []
      subnet_ids         = var.lambda_subnet_ids
      security_group_ids = var.lambda_security_group_ids
    }
    #    four-wheels-deployment = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Function to prepare and handle 4wheels deplyoments"
    #      memory_size        = 1024
    #      timeout            = 300
    #      source_file_path   = "../../../src/backend/order_handlers/four_wheels_deployment.py"
    #      output_file_path   = "../../../build/four_wheels_deployment.zip"
    #      handler            = "four_wheels_deployment.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {}
    #      event_sources = {
    #        sqs = {
    #          enabled           = var.lambda_trigger_sqs_enabled
    #          filter_criteria   = null
    #          batch_size        = 10
    #          starting_position = null
    #          source_arn        = module.sqs.queues.four-wheels-deployment-updates.arn
    #        }
    #      }
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    idp-mgmt = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn,
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Function to manage orders with Active Directory and DynamoDB"
    #      memory_size        = 256
    #      timeout            = 300
    #      source_file_path   = "../../../src/backend/order_handlers/idp_mgmt.py"
    #      output_file_path   = "../../../build/idp_mgmt.zip"
    #      handler            = "idp_mgmt.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        STEPFUNCTION_ARN                = var.prefix == "" ? "arn:aws-cn:states:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stateMachine:grant-temporary-access" : "arn:aws-cn:states:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:stateMachine:${var.prefix}-grant-temporary-access"
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #        ORDER_TABLE_NAME                = local.dynamodb_tables["order-information"].id
    #        LOCKING_TABLE_NAME              = local.dynamodb_tables["resource-locking"].id
    #        IDP_USER_TABLE_NAME             = local.dynamodb_tables["user-idp-information"].id
    #        SSM_AD_CREDENTIALS              = data.terraform_remote_state.common_account_infra.outputs.ad_credentials_ssm_parameter_name
    #        CDH_NOTIFICATION_SNS_TOPIC      = module.cdh_notification_sns.arn
    #      }
    #      permissions        = {}
    #      event_sources      = {}
    #      subnet_ids         = data.terraform_remote_state.common_account_infra.outputs.lambda_subnet_ids
    #      security_group_ids = [data.terraform_remote_state.common_account_infra.outputs.lambda_security_group_id]
    #    }
    #    mailtools-bridge = {
    #      description      = "Customer Portal - Call MAILTOOLS Endpoint"
    #      memory_size      = 512
    #      timeout          = 600
    #      runtime          = var.lambda_python_runtime
    #      publish          = var.lambda_create_versions
    #      source_file_path = "../../../src/backend/mailtools_bridge.py"
    #      output_file_path = "../../../build/mailtool_bridge.zip"
    #      handler          = "mailtools_bridge.lambda_handler"
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn,
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      environment_variables = {
    #        DEBUGING_LEVEL                  = var.lambda_logging_level
    #        MAILTOOLS_DATA                  = module.mailtools_param.name
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions        = {}
    #      event_sources      = {}
    #      subnet_ids         = data.terraform_remote_state.common_account_infra.outputs.lambda_subnet_ids
    #      security_group_ids = [data.terraform_remote_state.common_account_infra.outputs.lambda_security_group_id]
    #    }
    #    network-deployment = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Create, update and delete VPCs and VPC Peerings"
    #      memory_size        = 512
    #      timeout            = 600
    #      source_file_path   = "../../../src/backend/order_handlers/network_deployment.py"
    #      output_file_path   = "../../../build/network_deployment.zip"
    #      handler            = "network_deployment.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions        = {}
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    tufin-bridge = {
    #      description      = "Customer Portal - Call TUFIN Endpoint"
    #      memory_size      = 512
    #      timeout          = 600
    #      runtime          = var.lambda_python_runtime
    #      publish          = var.lambda_create_versions
    #      source_file_path = "../../../src/backend/tufin_bridge.py"
    #      output_file_path = "../../../build/tufin_bridge.zip"
    #      handler          = "tufin_bridge.lambda_handler"
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn,
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      environment_variables = {
    #        DEBUGING_LEVEL = var.lambda_logging_level
    #        TUFIN_DATA     = module.tufin_param.name
    #      }
    #      permissions        = {}
    #      event_sources      = {}
    #      subnet_ids         = data.terraform_remote_state.common_account_infra.outputs.lambda_subnet_ids
    #      security_group_ids = [data.terraform_remote_state.common_account_infra.outputs.lambda_security_group_id]
    #    }
    #    organizations-mgmt = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Actions with AWS Organizations"
    #      memory_size        = 128
    #      timeout            = 30
    #      source_file_path   = "../../../src/backend/order_handlers/organizations_mgmt.py"
    #      output_file_path   = "../../../build/organizations_mgmt.zip"
    #      handler            = "organizations_mgmt.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions        = {}
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    scp-switch = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Toggle SCP switches for an AWS account"
    #      memory_size        = 256
    #      timeout            = 60
    #      source_file_path   = "../../../src/backend/order_handlers/scp_switch.py"
    #      output_file_path   = "../../../build/scp_switch.zip"
    #      handler            = "scp_switch.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions        = {}
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    trigger-step-functions = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Trigger Step Functions"
    #      memory_size        = 128
    #      timeout            = 200
    #      source_file_path   = "../../../src/backend/order_handlers/trigger_step_functions_mgmt.py"
    #      output_file_path   = "../../../build/trigger_step_functions_mgmt.zip"
    #      handler            = "trigger_step_functions_mgmt.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions        = {}
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    user-mgmt = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Creates, delete or appends user, depending on an input JSON file"
    #      memory_size        = 256
    #      timeout            = 60
    #      source_file_path   = "../../../src/backend/order_handlers/user_mgmt.py"
    #      output_file_path   = "../../../build/user_mgmt.zip"
    #      handler            = "user_mgmt.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions        = {}
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    # CLOUDWATCH EVENTS TRIGGERED / SCHEDULED FUNCTIONS
    #    check-account-suspension = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Check Account Suspension based on APP-ID and Projectplanposition"
    #      memory_size        = 256
    #      timeout            = 300
    #      source_file_path   = "../../../src/backend/check_account_suspension.py"
    #      output_file_path   = "../../../build/check_account_suspension.zip"
    #      handler            = "check_account_suspension.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #        EXPIRATION_REMINDER_DAYS        = "1,2,3,4,5,6,7,14,21,28"
    #      }
    #      permissions = {
    #        cloud_watch_event_daily = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["check-account-suspension"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    check-cidr-ranges = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Check Network DB about how many CIDRs are still available in each region"
    #      memory_size        = 1024
    #      timeout            = 300
    #      source_file_path   = "../../../src/backend/check_cidr_ranges.py"
    #      output_file_path   = "../../../build/check_cidr_ranges.zip"
    #      handler            = "check_cidr_ranges.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #        NETWORK_TABLE_NAME              = local.dynamodb_tables["network-details"].id
    #        ITSM_CONTRACT_DATA              = module.itsm_param.name
    #      }
    #      permissions = {
    #        cloud_watch_event_weekly = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["check-free-cidrs"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    check-sbus-data = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Check for accounts of vpcs that are not reported into SBUS"
    #      memory_size        = 128
    #      timeout            = 300
    #      source_file_path   = "../../../src/backend/check_sbus_data.py"
    #      output_file_path   = "../../../build/check_sbus_data.zip"
    #      handler            = "check_sbus_data.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {
    #        cloud_watch_event_daily = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["check-sbus-data"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    check-dead-letter-queues = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Check for messages in the dead-letter-queues and try to reprocess it"
    #      memory_size        = 128
    #      timeout            = 180
    #      source_file_path   = "../../../src/backend/check_dead_letter_queues.py"
    #      output_file_path   = "../../../build/check_dead_letter_queues.zip"
    #      handler            = "check_dead_letter_queues.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {
    #        cloud_watch_event_daily = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["check-dead-letter-queues"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    check-manual-pending-orders = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Check if there are unapproved pending orders"
    #      memory_size        = 256
    #      timeout            = 300
    #      source_file_path   = "../../../src/backend/check_manual_pending_orders.py"
    #      output_file_path   = "../../../build/check_manual_pending_orders.zip"
    #      handler            = "check_manual_pending_orders.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        ITSM_CONTRACT_DATA              = module.itsm_param.name
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {
    #        cloud_watch_event_weekly = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["check-manual-pending-orders"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    check-training-status = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Check Training Status and prepare/cleanup training accounts"
    #      memory_size        = 256
    #      timeout            = 300
    #      source_file_path   = "../../../src/backend/check_training_status.py"
    #      output_file_path   = "../../../build/check_training_status.zip"
    #      handler            = "check_training_status.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #        SNS_TOPIC_ARN                   = module.traffic_action_sns.arn
    #      }
    #      permissions = {
    #        cloud_watch_event_daily = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["check-training-status"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    dynamodb-to-sqs = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Create SQS Messages for every single DynamoDB record from a Table"
    #      memory_size        = 512
    #      timeout            = 120
    #      source_file_path   = "../../../src/backend/dynamodb_to_sqs.py"
    #      output_file_path   = "../../../build/dynamodb_to_sqs.zip"
    #      handler            = "dynamodb_to_sqs.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {
    #        cloud_watch_event_update_network = {
    #          statement_id = "EventBridgeUpdateNetwork"
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-dynamodb-network-info"].arn
    #        }
    #        cloud_watch_event_update_dns = {
    #          statement_id = "EventBridgeUpdateDNS"
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-dynamodb-hosted-zone-info"].arn
    #        }
    #        cloud_watch_event_update_account = {
    #          statement_id = "EventBridgeUpdateAccount"
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-dynamodb-account-info"].arn
    #        }
    #        cloud_watch_event_update_account_principals = {
    #          statement_id = "EventBridgeUpdateAccountPrincipals"
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-dynamodb-account-principals"].arn
    #        }
    #        cloud_watch_event_update_security_hub = {
    #          statement_id = "EventBridgeUpdateSecurityHub"
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-dynamodb-security-hub-info"].arn
    #        }
    #        cloud_watch_event_update_idps = {
    #          statement_id = "EventBridgeUpdateIdPs"
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-dynamodb-idp-info"].arn
    #        }
    #        cloud_watch_event_update_unused_iam_user_credentials = {
    #          statement_id = "EventBridgeUpdateUnusedIAMUserCrendentials"
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-unused-iam-user-credentials"].arn
    #        }
    #        cloud_watch_event_update_vpc_inventory = {
    #          statement_id = "EventBridgeUpdateVPCsInventory"
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-vpc-info-from-account-info"].arn
    #        }
    #        cloud_watch_event_update_hosted_zone_inventory = {
    #          statement_id = "EventBridgeUpdateHostedZonesInventory"
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-hosted-zone-info-from-account-info"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    idp-list-ad-groups = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - List AD Groups and Memberships and Update DynamoDB"
    #      memory_size        = 512
    #      timeout            = 900
    #      source_file_path   = "../../../src/backend/idp_list_ad_groups.py"
    #      output_file_path   = "../../../build/idp_list_ad_groups.zip"
    #      handler            = "idp_list_ad_groups.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #        IDP_USER_TABLE_NAME             = local.dynamodb_tables["user-idp-information"].id
    #        IDP_GROUPS_TABLE_NAME           = local.dynamodb_tables["user-idp-groups"].id
    #        SSM_AD_CREDENTIALS              = data.terraform_remote_state.common_account_infra.outputs.ad_credentials_ssm_parameter_name
    #        ASSIGN_TTL                      = var.dynamodb_set_ttl
    #      }
    #      permissions = {
    #        cloud_watch_event_every_20_mins = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-dynamodb-ad-groups"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = data.terraform_remote_state.common_account_infra.outputs.lambda_subnet_ids
    #      security_group_ids = [data.terraform_remote_state.common_account_infra.outputs.lambda_security_group_id]
    #    }
    #    populate-account-stats = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Populate Database with account statistics"
    #      memory_size        = 512
    #      timeout            = 900
    #      source_file_path   = "../../../src/backend/populate_accounts_statistics.py"
    #      output_file_path   = "../../../build/populate_accounts_statistics.zip"
    #      handler            = "populate_accounts_statistics.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {
    #        cloud_watch_event_daily = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["populate-account-stats"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    populate-order-stats = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Populate Database with orders statistics"
    #      memory_size        = 512
    #      timeout            = 900
    #      source_file_path   = "../../../src/backend/populate_orders_statistics.py"
    #      output_file_path   = "../../../build/populate_orders_statistics.zip"
    #      handler            = "populate_orders_statistics.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {
    #        cloud_watch_event_daily = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["populate-order-stats"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    populate-network-stats = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Populate Database with network statistics"
    #      memory_size        = 512
    #      timeout            = 900
    #      source_file_path   = "../../../src/backend/populate_network_statistics.py"
    #      output_file_path   = "../../../build/populate_network_statistics.zip"
    #      handler            = "populate_network_statistics.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {
    #        cloud_watch_event_daily = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["populate-network-stats"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    update-portal-permissions = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Update the DynamoDB portal permissions based on the ADGR Groups data"
    #      memory_size        = 512
    #      timeout            = 900
    #      source_file_path   = "../../../src/backend/update_portal_permissions.py"
    #      output_file_path   = "../../../build/update_portal_permissions.zip"
    #      handler            = "update_portal_permissions.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {
    #        cloud_watch_event_half_an_hour = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-portal-permissions"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = data.terraform_remote_state.common_account_infra.outputs.lambda_subnet_ids
    #      security_group_ids = [data.terraform_remote_state.common_account_infra.outputs.lambda_security_group_id]
    #    }
    #    update-account-details-organizations = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn,
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Read AWS Account information from AWS Organizations and update DynamoDB"
    #      memory_size        = 512
    #      timeout            = 300
    #      source_file_path   = "../../../src/backend/update_account_details_organizations.py"
    #      output_file_path   = "../../../build/update_account_details_organizations.zip"
    #      handler            = "update_account_details_organizations.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #        ACCOUNT_TABLE_NAME              = local.dynamodb_tables["account-information"].id
    #      }
    #      permissions = {
    #        cloud_watch_event_daily = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-dynamodb-account-details-organizations"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    update-account-aliases = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Create AWS account aliases for training accounts"
    #      memory_size        = 512
    #      timeout            = 300
    #      source_file_path   = "../../../src/backend/update_account_aliases.py"
    #      output_file_path   = "../../../build/update_account_aliases.zip"
    #      handler            = "update_account_aliases.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions        = {}
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    update-api-key-db = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Function to Update the DynamoDB with API Key information"
    #      memory_size        = 128
    #      timeout            = 300
    #      source_file_path   = "../../../src/backend/update_api_key_db.py"
    #      output_file_path   = "../../../build/update_api_key_db.zip"
    #      handler            = "update_api_key_db.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {
    #        cloud_watch_event_half_an_hour = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-dynamodb-api-key-info"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    update-billing-db = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Update Billing DB"
    #      memory_size        = 512
    #      timeout            = 600
    #      source_file_path   = "../../../src/backend/update_billing_db.py"
    #      output_file_path   = "../../../build/update_billing_db.zip"
    #      handler            = "update_billing_db.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {
    #        cloud_watch_event_daily = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-dynamodb-billing-info"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    update-cdh-account-principals-worker = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Function to Update the DynamoDB with account principals information from the CDH User API"
    #      memory_size        = 512
    #      timeout            = 300
    #      source_file_path   = "../../../src/backend/update_cdh_account_principals_worker.py"
    #      output_file_path   = "../../../build/update_cdh_account_principals_worker.zip"
    #      handler            = "update_cdh_account_principals_worker.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {
    #        cloud_watch_event_every_23_hours = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-cdh-permissions"].arn
    #        }
    #      }
    #      event_sources = {
    #        # we can also trigger this function by SQS in case we need to trigger actions from the frontend for a specific
    #        # case: for accounts or for users
    #        sqs = {
    #          enabled           = var.lambda_trigger_sqs_enabled
    #          filter_criteria   = null
    #          batch_size        = 1
    #          starting_position = null
    #          source_arn        = module.sqs.queues.cdh-permissions-update-distribution.arn
    #        }
    #      }
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    update-contact-dls = {
    #      description      = "Customer Portal - Update the Contact Distribution List"
    #      memory_size      = 512
    #      timeout          = 600
    #      runtime          = var.lambda_python_runtime
    #      publish          = var.lambda_create_versions
    #      source_file_path = "../../../src/backend/update_contact_dls.py"
    #      output_file_path = "../../../build/update_contact_dls.zip"
    #      handler          = "update_contact_dls.lambda_handler"
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn,
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      environment_variables = {
    #        DEBUGING_LEVEL                  = var.lambda_logging_level
    #        MAILTOOLS_DATA                  = module.mailtools_param.name
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {
    #        cloud_watch_event_hourly = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-contact-dls"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = data.terraform_remote_state.common_account_infra.outputs.lambda_subnet_ids
    #      security_group_ids = [data.terraform_remote_state.common_account_infra.outputs.lambda_security_group_id]
    #    }
    #    update-dx-gw-db = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - List all Direct Connect Gateways and update DynamoDB"
    #      memory_size        = 512
    #      timeout            = 600
    #      source_file_path   = "../../../src/backend/update_dx_gw_db.py"
    #      output_file_path   = "../../../build/update_dx_gw_db.zip"
    #      handler            = "update_dx_gw_db.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #        ITSM_CONTRACT_DATA              = module.itsm_param.name
    #      }
    #      permissions = {
    #        cloud_watch_event_quarter_hourly = {
    #          statement_id = "cwevent15"
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-dynamodb-dx-gateway-info"].arn
    #        }
    #        cloud_watch_event_daily = {
    #          statement_id = "cweventdaily"
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["check-free-dx-gateway-associations"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    update-idp-user-db = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn,
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Function to update DynamoDB with enabled Active Directory users"
    #      memory_size        = 512
    #      timeout            = 600
    #      source_file_path   = "../../../src/backend/update_idp_user_db.py"
    #      output_file_path   = "../../../build/update_idp_user_db.zip"
    #      handler            = "update_idp_user_db.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #        IDP_USER_TABLE_NAME             = local.dynamodb_tables["user-idp-information"].id
    #        SSM_AD_CREDENTIALS              = data.terraform_remote_state.common_account_infra.outputs.ad_credentials_ssm_parameter_name
    #        ASSIGN_TTL                      = var.dynamodb_set_ttl
    #      }
    #      permissions = {
    #        cloud_watch_event_hourly = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-dynamodb-idp-user-info"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = data.terraform_remote_state.common_account_infra.outputs.lambda_subnet_ids
    #      security_group_ids = [data.terraform_remote_state.common_account_infra.outputs.lambda_security_group_id]
    #    }
    #    update-organizations-settings = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn,
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - List Organizational Units from available Master Accounts"
    #      memory_size        = 512
    #      timeout            = 300
    #      source_file_path   = "../../../src/backend/update_org_settings.py"
    #      output_file_path   = "../../../build/update_org_settings.zip"
    #      handler            = "update_org_settings.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {
    #        cloud_watch_event_hourly = {
    #          statement_id = local.lambda_cloud_watch_permission_default_statement_id
    #          principal    = local.lambda_cloud_watch_permission_default_principal
    #          source_arn   = module.events.rules["update-dynamodb-organizations-details"].arn
    #        }
    #      }
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    # DYNAMODB STREAMS TRIGGERED FUNCTIONS
    #    process-orders = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Process Orders from DynamoDB"
    #      memory_size        = 128
    #      timeout            = 900
    #      source_file_path   = "../../../src/backend/process_orders.py"
    #      output_file_path   = "../../../build/process_orders.zip"
    #      handler            = "process_orders.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {}
    #      event_sources = {
    #        dynamodb = {
    #          enabled           = var.lambda_trigger_dynamodb_enabled
    #          filter_criteria   = local.filter_criteria_process_orders
    #          batch_size        = 1
    #          starting_position = "LATEST"
    #          source_arn        = local.dynamodb_tables["order-information"].stream_arn
    #        }
    #      }
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    check-account-updates = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Triggered by Changes in Account Information DynamoDB"
    #      memory_size        = 256
    #      timeout            = 600
    #      source_file_path   = "../../../src/backend/check_account_updates.py"
    #      output_file_path   = "../../../build/check_account_updates.zip"
    #      handler            = "check_account_updates.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #        SPLUNK_ACC_QUEUE_URL            = var.splunk_acc_queue_url
    #        ITSM_CONTRACT_DATA              = module.itsm_param.name
    #        BILLING_DB_SQS                  = module.sqs.queues.billing_db_notifications.id
    #      }
    #      permissions = {}
    #      event_sources = {
    #        dynamodb = {
    #          enabled           = var.lambda_trigger_dynamodb_enabled
    #          filter_criteria   = null
    #          batch_size        = 10
    #          starting_position = "LATEST"
    #          source_arn        = local.dynamodb_tables["account-information"].stream_arn
    #        }
    #      }
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    audit-trigger = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Triggered by changes in the tables we want to keep track of the changes"
    #      memory_size        = 256
    #      timeout            = 90
    #      source_file_path   = "../../../src/backend/audit_trigger.py"
    #      output_file_path   = "../../../build/audit_trigger.zip"
    #      handler            = "audit_trigger.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {}
    #      event_sources = {
    #        dynamodb_account = {
    #          enabled           = var.lambda_trigger_dynamodb_enabled
    #          filter_criteria   = null
    #          batch_size        = 1
    #          starting_position = "LATEST"
    #          source_arn        = local.dynamodb_tables["account-information"].stream_arn
    #        }
    #        dynamodb_dns = {
    #          enabled           = var.lambda_trigger_dynamodb_enabled
    #          filter_criteria   = null
    #          batch_size        = 1
    #          starting_position = "LATEST"
    #          source_arn        = local.dynamodb_tables["dns-information"].stream_arn
    #        }
    #        dynamodb_network = {
    #          enabled           = var.lambda_trigger_dynamodb_enabled
    #          filter_criteria   = null
    #          batch_size        = 1
    #          starting_position = "LATEST"
    #          source_arn        = local.dynamodb_tables["network-details"].stream_arn
    #        }
    #        dynamodb_order = {
    #          enabled           = var.lambda_trigger_dynamodb_enabled
    #          filter_criteria   = null
    #          batch_size        = 1
    #          starting_position = "LATEST"
    #          source_arn        = local.dynamodb_tables["order-information"].stream_arn
    #        }
    #        dynamodb_training = {
    #          enabled           = var.lambda_trigger_dynamodb_enabled
    #          filter_criteria   = null
    #          batch_size        = 1
    #          starting_position = "LATEST"
    #          source_arn        = local.dynamodb_tables["training-information"].stream_arn
    #        }
    #      }
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    # SQS TRIGGERED FUNCTIONS
    #    billing-db-mgmt = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Send new accounts informations to the Billing DB"
    #      memory_size        = 128
    #      timeout            = 60
    #      source_file_path   = "../../../src/backend/billing_db_mgmt.py"
    #      output_file_path   = "../../../build/billing_db_mgmt.zip"
    #      handler            = "billing_db_mgmt.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #        BILLING_DB_API_SSM_PARAMETER    = data.terraform_remote_state.common_account_infra.outputs.cloud_next_configuration_ssm_parameter_name
    #        CLOUD_REGION                    = length(regexall(".*cn.*", var.prefix)) > 0 ? "CHINA" : ""
    #      }
    #      permissions = {}
    #      event_sources = {
    #        sqs = {
    #          enabled           = var.lambda_trigger_sqs_enabled
    #          filter_criteria   = null
    #          batch_size        = 1
    #          starting_position = null
    #          source_arn        = module.sqs.queues.billing_db_notifications.arn
    #        }
    #      }
    #      subnet_ids         = data.terraform_remote_state.common_account_infra.outputs.lambda_subnet_ids
    #      security_group_ids = [data.terraform_remote_state.common_account_infra.outputs.lambda_security_group_id]
    #    }
    #    sbus-mgmt = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Read and Update Security Hub information and update DynamoDB"
    #      memory_size        = 128
    #      timeout            = 60
    #      source_file_path   = "../../../src/backend/sbus_mgmt.py"
    #      output_file_path   = "../../../build/sbus_mgmt.zip"
    #      handler            = "sbus_mgmt.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                   = var.lambda_logging_level
    #        PORTAL_SOURCE                     = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME   = local.portal_configuration_table.id
    #        SBUS_API_SSM_PARAMETER_NAME       = module.sbus_param.name
    #        SBUS_API_TOKEN_SSM_PARAMETER_NAME = module.sbus_token_param.name
    #      }
    #      permissions = {}
    #      event_sources = {
    #        sqs = {
    #          enabled           = var.lambda_trigger_sqs_enabled
    #          filter_criteria   = null
    #          batch_size        = 1
    #          starting_position = null
    #          source_arn        = module.sqs.queues.sbus-update-distribution.arn
    #        }
    #      }
    #      subnet_ids         = data.terraform_remote_state.common_account_infra.outputs.lambda_subnet_ids
    #      security_group_ids = [data.terraform_remote_state.common_account_infra.outputs.lambda_security_group_id]
    #    }
    #    send-email = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Send email notification with response from order"
    #      memory_size        = 256
    #      timeout            = 300
    #      source_file_path   = "../../../src/backend/send_email.py"
    #      output_file_path   = "../../../build/send_email.zip"
    #      handler            = "send_email.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #        SSM_PATH                        = var.prefix == "" ? var.ssm_parameter_bmw_internal_mail : "${var.prefix}.${var.ssm_parameter_bmw_internal_mail}"
    #      }
    #      permissions = {}
    #      event_sources = {
    #        sqs = {
    #          enabled           = var.lambda_trigger_sqs_enabled
    #          filter_criteria   = null
    #          batch_size        = 1
    #          starting_position = null
    #          source_arn        = module.sqs.queues.send-mail-distribution.arn
    #        }
    #      }
    #      subnet_ids         = data.terraform_remote_state.common_account_infra.outputs.lambda_subnet_ids
    #      security_group_ids = [data.terraform_remote_state.common_account_infra.outputs.lambda_security_group_id]
    #    }
    #    update-account-details-worker = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Read AWS Account information and update DynamoDB"
    #      memory_size        = 512
    #      timeout            = 60
    #      source_file_path   = "../../../src/backend/update_account_details_worker.py"
    #      output_file_path   = "../../../build/update_account_details_worker.zip"
    #      handler            = "update_account_details_worker.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {}
    #      event_sources = {
    #        sqs = {
    #          enabled           = var.lambda_trigger_sqs_enabled
    #          filter_criteria   = null
    #          batch_size        = 10
    #          starting_position = null
    #          source_arn        = module.sqs.queues.traffic-ping-task.arn
    #        }
    #      }
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    update-account-principals-worker = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Function to Update the DynamoDB with account principals information"
    #      memory_size        = 512
    #      timeout            = 120
    #      source_file_path   = "../../../src/backend/update_account_principals_worker.py"
    #      output_file_path   = "../../../build/update_account_principals_worker.zip"
    #      handler            = "update_account_principals_worker.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {}
    #      event_sources = {
    #        sqs = {
    #          enabled           = var.lambda_trigger_sqs_enabled
    #          filter_criteria   = null
    #          batch_size        = 10
    #          starting_position = null
    #          source_arn        = module.sqs.queues.account-principals-update-distribution.arn
    #        }
    #      }
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    update-hosted-zone-details-worker = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Read Route 53 Hosted Zone information and update DynamoDB"
    #      memory_size        = 512
    #      timeout            = 500
    #      source_file_path   = "../../../src/backend/update_hosted_zone_details_worker.py"
    #      output_file_path   = "../../../build/update_hosted_zone_details_worker.zip"
    #      handler            = "update_hosted_zone_details_worker.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {}
    #      event_sources = {
    #        sqs = {
    #          enabled           = var.lambda_trigger_sqs_enabled
    #          filter_criteria   = null
    #          batch_size        = 10
    #          starting_position = null
    #          source_arn        = module.sqs.queues.hosted-zone-update-distribution.arn
    #        }
    #      }
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    update-hosted-zone-inventory = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Make inventory of all existent Hosted Zones and update DynamoDB"
    #      memory_size        = 2048
    #      timeout            = 180
    #      source_file_path   = "../../../src/backend/update_hosted_zone_inventory.py"
    #      output_file_path   = "../../../build/update_hosted_zone_inventory.zip"
    #      handler            = "update_hosted_zone_inventory.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {}
    #      event_sources = {
    #        sqs = {
    #          enabled           = var.lambda_trigger_sqs_enabled
    #          filter_criteria   = null
    #          batch_size        = 1
    #          starting_position = null
    #          source_arn        = module.sqs.queues.update-hosted-zone-inventory-from-accounts.arn
    #        }
    #      }
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    update-idp-worker = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Read and Update IdP information"
    #      memory_size        = 1024
    #      timeout            = 120
    #      source_file_path   = "../../../src/backend/update_idp_worker.py"
    #      output_file_path   = "../../../build/update_idp_worker.zip"
    #      handler            = "update_idp_worker.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {}
    #      event_sources = {
    #        sqs = {
    #          enabled           = var.lambda_trigger_sqs_enabled
    #          filter_criteria   = null
    #          batch_size        = 5
    #          starting_position = null
    #          source_arn        = module.sqs.queues.idp-update-distribution.arn
    #        }
    #      }
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    update-security-hub-worker = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Read and Update Security Hub information and update DynamoDB"
    #      memory_size        = 512
    #      timeout            = 600
    #      source_file_path   = "../../../src/backend/update_security_hub_worker.py"
    #      output_file_path   = "../../../build/update_security_hub_worker.zip"
    #      handler            = "update_security_hub_worker.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {}
    #      event_sources = {
    #        sqs = {
    #          enabled           = var.lambda_trigger_sqs_enabled
    #          filter_criteria   = null
    #          batch_size        = 5
    #          starting_position = null
    #          source_arn        = module.sqs.queues.security-hub-update-distribution.arn
    #        }
    #      }
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    update-unused-iam-user-credentials = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Check for unused IAM User credentials, disable them and notify account responsibles"
    #      memory_size        = 256
    #      timeout            = 180
    #      source_file_path   = "../../../src/backend/update_unused_iam_user_credentials.py"
    #      output_file_path   = "../../../build/update_unused_iam_user_credentials.zip"
    #      handler            = "update_unused_iam_user_credentials.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {}
    #      event_sources = {
    #        sqs = {
    #          enabled           = var.lambda_trigger_sqs_enabled
    #          filter_criteria   = null
    #          batch_size        = 10
    #          starting_position = null
    #          source_arn        = module.sqs.queues.unused-iam-credentials-distribution.arn
    #        }
    #      }
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    update-vpc-details-worker = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Read VPC information and update DynamoDB"
    #      memory_size        = 1024
    #      timeout            = 180
    #      source_file_path   = "../../../src/backend/update_vpc_details_worker.py"
    #      output_file_path   = "../../../build/update_vpc_details_worker.zip"
    #      handler            = "update_vpc_details_worker.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {}
    #      event_sources = {
    #        sqs = {
    #          enabled           = var.lambda_trigger_sqs_enabled
    #          filter_criteria   = null
    #          batch_size        = 10
    #          starting_position = null
    #          source_arn        = module.sqs.queues.vpc-update-distribution.arn
    #        }
    #      }
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    update-vpc-inventory = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Make inventory of all existent VPC's  and update DynamoDB"
    #      memory_size        = 2048
    #      timeout            = 180
    #      source_file_path   = "../../../src/backend/update_vpc_inventory.py"
    #      output_file_path   = "../../../build/update_vpc_inventory.zip"
    #      handler            = "update_vpc_inventory.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions = {}
    #      event_sources = {
    #        sqs = {
    #          enabled           = var.lambda_trigger_sqs_enabled
    #          filter_criteria   = null
    #          batch_size        = 1
    #          starting_position = null
    #          source_arn        = module.sqs.queues.update-vpc-inventory-from-accounts.arn
    #        }
    #      }
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    # STEP FUNCTION TRIGGERED FUNCTION
    #    step-function-helper = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Function to workaround some of the Step Functions limitations"
    #      memory_size        = 128
    #      timeout            = 10
    #      source_file_path   = "../../../src/backend/step_function_helper.py"
    #      output_file_path   = "../../../build/step_function_helper.zip"
    #      handler            = "step_function_helper.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions        = {}
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    finalize-grant-purchase-role-order = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - Function to finalize the process of the grant purchase role process"
    #      memory_size        = 128
    #      timeout            = 60
    #      source_file_path   = "../../../src/backend/order_handlers/finalize_grant_purchase_role_order.py"
    #      output_file_path   = "../../../build/finalize_grant_purchase_role_order.zip"
    #      handler            = "finalize_grant_purchase_role_order.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions        = {}
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #    }
    #    network-tests-handler = {
    #      runtime = var.lambda_python_runtime
    #      publish = var.lambda_create_versions
    #      layers_arns = [
    #        data.terraform_remote_state.lambda_layers.outputs.layers["general-dependencies"].arn,
    #        data.terraform_remote_state.lambda_layers.outputs.layers["core-library"].arn
    #      ]
    #      role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    #      log_retention_days = var.lambda_log_retention_days
    #      description        = "Customer Portal - VPC Networks tests handler"
    #      memory_size        = 256
    #      timeout            = 300
    #      source_file_path   = "../../../src/backend/network_tests_handler.py"
    #      output_file_path   = "../../../build/network_tests_handler.zip"
    #      handler            = "network_tests_handler.lambda_handler"
    #      environment_variables = {
    #        DEBUGGING_LEVEL                 = var.lambda_logging_level
    #        PORTAL_SOURCE                   = module.error_events.events_source
    #        PORTAL_CONFIGURATION_TABLE_NAME = local.portal_configuration_table.id
    #      }
    #      permissions        = {}
    #      event_sources      = {}
    #      subnet_ids         = []
    #      security_group_ids = []
    #
    #    }
  }
}
