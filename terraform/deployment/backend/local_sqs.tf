locals {
  default_sqs_queue_specs = {
    lambda_role_arn           = data.terraform_remote_state.common_account_infra.outputs.lambda_role.arn
    message_retention_seconds = 86400
    delay_seconds             = 10
    receive_wait_time_seconds = 5
    redrive_policy            = null
  }

  sqs_queue_specs = {
    # traffic-ping-task
    traffic-ping-task = {
      visibility_timeout_seconds = 120
      message_retention_seconds  = 120
      delay_seconds              = 0
      receive_wait_time_seconds  = 0
    }
#    vpc-update-distribution = {
#      visibility_timeout_seconds = 180
#    }
#    update-vpc-inventory-from-accounts = {
#      visibility_timeout_seconds = 180
#    }
#    update-hosted-zone-inventory-from-accounts = {
#      visibility_timeout_seconds = 180
#    }
#    hosted-zone-update-distribution = {
#      visibility_timeout_seconds = 500
#    }
#    four-wheels-deployment-updates = {
#      # this is equivalent to
#      # lambda_role_arn            = "arn:aws-cn:iam::${var.four_wheels_automation_account_id}:root"
#      lambda_role_arn            = var.four_wheels_automation_account_id
#      visibility_timeout_seconds = 305
#    }
#    four-wheels-update-distribution = {
#      visibility_timeout_seconds = 65
#    }
#    security-hub-update-distribution = {
#      visibility_timeout_seconds = 600
#    }
#    idp-update-distribution = {
#      visibility_timeout_seconds = 125
#    }
#    sbus-update-distribution = {
#      visibility_timeout_seconds = 65
#      redrive_policy = {
#        dead_letter_target_arn = module.sqs_dead_letter.queues.sbus-dead-letter-queue.arn
#        max_receive_count      = 10
#      }
#    }
#    # TODO - can we change this using kebab case without have side effect?
#    billing_db_notifications = {
#      visibility_timeout_seconds = 65
#      redrive_policy = {
#        dead_letter_target_arn = module.sqs_dead_letter.queues.billing-db-dead-letter-queue.arn
#        max_receive_count      = 10
#      }
#    }
#    account-principals-update-distribution = {
#      visibility_timeout_seconds = 125
#    }
#    send-mail-distribution = {
#      visibility_timeout_seconds = 300
#      redrive_policy = {
#        dead_letter_target_arn = module.sqs_dead_letter.queues.send-mail-dead-letter-queue.arn
#        max_receive_count      = 10
#      }
#    }
#    unused-iam-credentials-distribution = {
#      visibility_timeout_seconds = 180
#    }
#    cdh-permissions-update-distribution = {
#      visibility_timeout_seconds = 300
#      redrive_policy = {
#        dead_letter_target_arn = module.sqs_dead_letter.queues.cdh-permissions-dead-letter-queue.arn
#        max_receive_count      = 10
#      }
#    }
  }

#  dead_letter_sqs_queue_specs = {
#    sbus-dead-letter-queue = {
#      visibility_timeout_seconds = 65
#    }
#    billing-db-dead-letter-queue = {
#      visibility_timeout_seconds = 65
#    }
#    send-mail-dead-letter-queue = {
#      visibility_timeout_seconds = 65
#    }
#    cdh-permissions-dead-letter-queue = {
#      visibility_timeout_seconds = 65
#    }
#  }

  full_sqs_queue_specs = {
    for sqs_key, sqs_specs in local.sqs_queue_specs : sqs_key => merge(local.default_sqs_queue_specs, sqs_specs)
  }
#  full_dead_letter_sqs_queue_specs = {
#    for sqs_key, sqs_specs in local.dead_letter_sqs_queue_specs : sqs_key => merge(local.default_sqs_queue_specs, sqs_specs)
#  }
}
