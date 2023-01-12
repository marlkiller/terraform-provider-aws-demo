#output "lambda_functions" {
#  value = module.lambda_functions.functions
#}

output "sqs_queues" {
  value = module.sqs.queues
}

#output "sqs_dead_letter_queues" {
#  value = module.sqs_dead_letter.queues
#}
