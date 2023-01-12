#module "sqs_dead_letter" {
#  source = "../../modules/sqs"
#
#  prefix = var.prefix
#  tags   = var.tags
#
#  sqs_queue_specs = local.full_dead_letter_sqs_queue_specs
#}
