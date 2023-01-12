module "sqs" {
  source = "../../modules/sqs"

  prefix = var.prefix
  tags   = var.tags

  sqs_queue_specs = local.full_sqs_queue_specs
}
