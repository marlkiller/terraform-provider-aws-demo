output "queues" {
  value = {
    for key, queue in aws_sqs_queue.portal : key => {
      id  = queue.id
      arn = queue.arn
    }
  }
}
