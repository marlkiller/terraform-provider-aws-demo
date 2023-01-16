output "lambda_functions" {
  value = module.lambda_functions.functions
}

output "sqs_queues" {
  value = module.sqs.queues
}

output "events" {
  value = module.events.rules
}

output "error_events" {
  value = module.error_events.events_source
}

output "ssm_param" {
  value = module.traffic_config_param
}

#output "sqs_dead_letter_queues" {
#  value = module.sqs_dead_letter.queues
#}
