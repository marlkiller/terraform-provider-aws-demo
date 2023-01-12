resource "aws_sqs_queue" "portal" {
  for_each = var.sqs_queue_specs

  name                       = var.prefix == "" ? each.key : "${var.prefix}-${each.key}"
  visibility_timeout_seconds = each.value["visibility_timeout_seconds"]
  message_retention_seconds  = each.value["message_retention_seconds"]
  delay_seconds              = each.value["delay_seconds"]
  receive_wait_time_seconds  = each.value["receive_wait_time_seconds"]

  redrive_policy = each.value["redrive_policy"] == null ? null : jsonencode({
    deadLetterTargetArn = lookup(each.value["redrive_policy"], "dead_letter_target_arn", null)
    maxReceiveCount     = lookup(each.value["redrive_policy"], "max_receive_count", null)
  })

  tags = var.tags
}

resource "aws_sqs_queue_policy" "portal" {
  for_each = var.sqs_queue_specs

  queue_url = aws_sqs_queue.portal[each.key].id
  policy    = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "${each.value["lambda_role_arn"]}"
      },
      "Action": [
        "SQS:DeleteMessage",
        "SQS:ReceiveMessage",
        "SQS:GetQueueUrl",
        "SQS:GetQueueAttributes",
        "SQS:SendMessage"
      ],
      "Resource": "${aws_sqs_queue.portal[each.key].arn}"
    }
  ]
}
EOF

}
