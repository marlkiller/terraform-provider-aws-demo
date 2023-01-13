module "iam" {
  source = "../../modules/iam"

  lambda_role_name        = var.lambda_role_name
  lambda_role_description = var.lambda_role_description
  lambda_policy_name      = var.lambda_policy_name
  lambda_policy = templatefile("../../data/policies/lambda_role.json", {
    policy_id  = "customer-traffic-lambda-role",
    region     = data.aws_region.current.name,
    account_id = data.aws_caller_identity.current.account_id
    # needed since 4Wheels SQS is KMS encrypted
    # "User: arn:aws-cn:sts::558715975237:assumed-role/LambdaAutomation/prod-four-wheels-deployment
    # is not authorized to perform: kms:GenerateDataKey on resource: arn:aws-cn:kms:eu-central-1:387646815508:key/2e10f088-0aea-45a1-9a49-1f0f3ce697ae
    # because no identity-based policy allows the kms:GenerateDataKey action"
    # the variable four_wheels_automation_account_id is the 4Wheels account id
    # four_wheels_automation_account_id = var.four_wheels_automation_account_id
    # needed since the authentication on CDH User API gateway is granted at root level for the account where SSP is running
    # but dev and int has access to the CDH INT gateway, while prod and prod-cn has access to the CDH PROD gateway
    # cdh_api_gateway_region     = var.cdh_api_gateway_region
    # cdh_api_gateway_account_id = var.cdh_api_gateway_account_id
  })
  lambda_policy_attachment_arns = [
#    "arn:aws-cn:iam::aws:policy/service-role/AWSLambdaENIManagementAccess",
    "arn:aws-cn:iam::aws:policy/AmazonSQSFullAccess",
    "arn:aws-cn:iam::aws:policy/AmazonSNSFullAccess",
    "arn:aws-cn:iam::aws:policy/AmazonSNSFullAccess",
    "arn:aws-cn:iam::aws:policy/CloudWatchFullAccess",
    "arn:aws-cn:iam::aws:policy/AmazonEventBridgeFullAccess",
    "arn:aws-cn:iam::aws:policy/AmazonDynamoDBFullAccess",
    "arn:aws-cn:iam::aws:policy/AmazonSSMReadOnlyAccess",
    "arn:aws-cn:iam::aws:policy/AWSLambdaRole",
    "arn:aws-cn:iam::aws:policy/AWSLambdaBasicExecutionRole",
    "arn:aws-cn:iam::aws:policy/AmazonEC2FullAccess",
  ]

  tags = var.tags
}
