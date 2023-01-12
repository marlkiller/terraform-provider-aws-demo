
locals {
  policy = <<POLICY
{
   "Version": "2012-10-17",
   "Statement":[
    ${join(",", var.policies)}
]

}
POLICY
}

resource "aws_sns_topic" "aws_sns_topic_portal" {
  name         = var.prefix == "" ? var.topic_name : "${var.prefix}-${var.topic_name}"
  display_name = var.prefix == "" ? var.topic_name : "${var.prefix}-${var.topic_name}"
  policy       = local.policy
  #kms_master_key_id = var.kms_key_id
  tags = var.tags
}
