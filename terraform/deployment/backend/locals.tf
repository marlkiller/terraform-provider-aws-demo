locals {
  resource_prefix                                    = var.prefix == "" ? "" : "${var.prefix}-"
  parameter_prefix                                   = var.prefix == "" ? "" : "${var.prefix}."
  #  portal_region                                      = lookup(var.account_id_portal_region_mapping, data.aws_caller_identity.current.account_id)
  #  dynamodb_tables                                    = data.terraform_remote_state.datastores.outputs.dynamodb_tables
  #  portal_configuration_table                         = local.dynamodb_tables["portal-config"]
  lambda_cloud_watch_permission_default_statement_id = "AllowCloudWatchEventsInvoke"
  lambda_cloud_watch_permission_default_principal    = "events.amazonaws.com"
  #  lambda_details = {
  #    M = {
  #      for key, lambda_function in module.lambda_functions.functions : key => {
  #        M = {
  #          id            = { S = lambda_function.id }
  #          function_name = { S = lambda_function.function_name }
  #          arn           = { S = lambda_function.arn }
  #          invoke_arn    = { S = lambda_function.invoke_arn }
  #        }
  #      }
  #    }
  #  }
  #  sqs_updates_details = {
  #    M = {
  #      ("tables_updates") = {
  #        M = {
  #          (local.dynamodb_tables["account-information"].id) = {
  #            M = {
  #              sqs = { S = module.sqs.queues.traffic-ping-task.id }
  #            }
  #          }
  #          (local.dynamodb_tables["network-details"].id) = {
  #            M = {
  #              sqs = { S = module.sqs.queues.vpc-update-distribution.id }
  #            }
  #          }
  #          (local.dynamodb_tables["dns-information"].id) = {
  #            M = {
  #              sqs = { S = module.sqs.queues.hosted-zone-update-distribution.id }
  #            }
  #          }
  #          (local.dynamodb_tables["account-principals"].id) = {
  #            M = {
  #              sqs = { S = module.sqs.queues.account-principals-update-distribution.id }
  #            }
  #          }
  #          (local.dynamodb_tables["idp-information"].id) = {
  #            M = {
  #              sqs = { S = module.sqs.queues.idp-update-distribution.id }
  #            }
  #          }
  #        }
  #      }
  #      ("services_updates") = {
  #        M = {
  #          ("security-hub-updates") = {
  #            M = {
  #              sqs = { S = module.sqs.queues.security-hub-update-distribution.id }
  #            }
  #          }
  #          ("sbus-updates") = {
  #            M = {
  #              sqs         = { S = module.sqs.queues.sbus-update-distribution.id }
  #              dead_letter = { S = module.sqs_dead_letter.queues.sbus-dead-letter-queue.id }
  #            }
  #          }
  #          ("billing-db-notifications") = {
  #            M = {
  #              sqs         = { S = module.sqs.queues.billing_db_notifications.id }
  #              dead_letter = { S = module.sqs_dead_letter.queues.billing-db-dead-letter-queue.id }
  #            }
  #          }
  #          ("send-mail") = {
  #            M = {
  #              sqs         = { S = module.sqs.queues.send-mail-distribution.id }
  #              dead_letter = { S = module.sqs_dead_letter.queues.send-mail-dead-letter-queue.id }
  #            }
  #          }
  #          ("cdh-permissions") = {
  #            M = {
  #              sqs         = { S = module.sqs.queues.cdh-permissions-update-distribution.id }
  #              dead_letter = { S = module.sqs_dead_letter.queues.cdh-permissions-dead-letter-queue.id }
  #            }
  #          }
  #        }
  #      }
  #    }
  #  }
  #  grant_purchase_role_configuration = {
  #    # this to workaround circular dependecies if we pass it in the same way to the lambda function module
  #    M = {
  #      ("step_function_arn") = { S = var.deploy_grant_purchase_role ? module.portal_step_functions.step_functions["grant-purchase-role"].arn : "<arn>" }
  #      ("enabled")           = { BOOL = var.deploy_grant_purchase_role }
  #    }
  #  }
  #
  #  network_test_configuration = {
  #    M = {
  #      ("template")           = { S = aws_s3_object.network_test_cfn_template.id }
  #      ("tests_prefix_key")   = { S = "network_tests" }
  #      ("step_function_arn")  = { S = module.portal_step_functions.step_functions["network-test"].arn }
  #      ("stack_name_pattern") = { S = "fpc-network-test-vpc-id-{0}-subnet-id-{1}" }
  #      ("s3_bucket")          = { S = local.backend_s3 }
  #      ("s3_path")            = { S = local.network_test_logs_path }
  #    }
  #  }
  #
  #  email_templates_source_dir  = "${path.module}/../../../email_templates/${var.email_templates_env}"
  #  email_templates_input_files = fileset(local.email_templates_source_dir, "*")
  #  filter_criteria_process_orders = [
  #    jsonencode({
  #      eventName = [
  #        "INSERT"
  #      ]
  #    }),
  #    jsonencode({
  #      eventName = ["MODIFY"],
  #      dynamodb = {
  #        NewImage = {
  #          email_sent = {
  #            BOOL = [{ exists = false }, false]
  #          }
  #          executed = {
  #            S = ["NEW", "SUCCESS"]
  #          }
  #          # we could also replace it with exist filter
  #          approved = {
  #            S = ["NEW", "APPROVED", "DECLINED"]
  #          }
  #        }
  #      }
  #    }),
  #  ]
  #  backend_s3             = "backend-${var.prefix}-${data.aws_caller_identity.current.account_id}-${var.aws_region}"
  #  network_test_logs_path = "network_test_logs"
}
