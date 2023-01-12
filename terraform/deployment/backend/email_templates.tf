#resource "aws_s3_object" "email_templates" {
#  for_each = var.email_templates_prefix != "" ? local.email_templates_input_files : []
#
#  bucket = data.terraform_remote_state.common_account_infra.outputs.resource_bucket.id
#  key    = "${var.email_templates_prefix}/${each.value}"
#  source = "${local.email_templates_source_dir}/${each.value}"
#
#  etag = filemd5("${local.email_templates_source_dir}/${each.value}")
#  tags = var.tags
#}
