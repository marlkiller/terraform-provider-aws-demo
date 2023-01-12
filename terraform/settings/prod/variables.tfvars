##############################################
# GENERAL INFORMATION
##############################################

aws_profile = "558715975237_UserFull"
aws_region  = "cn-north-1"

tags = {
  environment = "prod"
  project     = "Network Monitor - China"
  creators    = "SSP-Cloud"
  emails      = "ncx-aws@list.bmw.com"
}

datadog_monitored = true
domain_name       = "manage.aws.bmw.cloud"
prefix            = "prod"

##############################################
# COMMON ACCOUNT INFRA DEPLOYMENT INFORMATION
##############################################

# the change of the name will delete and recreate the role,
# the role is used only for API Gateway Logging
api_gateway_role_name        = "prod-traffic-network-apigateway-logs"
lambda_role_name             = "TrafficLambdaAutomation"
nuke_account_role_name       = "prod-traffic-network-nuke-account-role"
stepfunction_role_name       = "prod-traffic-network-stepfunction-role"
vpc_id                       = "vpc-c13795a5"
portal_resources_bucket_name = "ccc-traffic-network-resources"
cdh_api_gateway_account_id   = "402318116903"

##############################################
# WAF LOGGING INFORMATIONS
##############################################

waf_api_gateway_web_acl_name = "FMManagedWebACLV2-BMW-WAFPolicy-Standard-API-Gateway-1639623474674"
waf_cloudfront_web_acl_name  = "FMManagedWebACLV2-BMW-WAFPolicy-Standard-CloudFront-1639627151047"
waf_s3_logging_bucket_arn    = "arn:aws-cn:s3:::aws-waf-logs-104485279185-cn-north-1"

##############################################
# COGNITO USER POOL INFORMATION
##############################################

cognito_trigger_role_name        = "prod-traffic-network-cognito-trigger-role"
cognito_user_pool_name           = "prod-traffic-network-idp"
is_oidc_idp_connected            = true
cognito_oidc_provider_name       = "BMWWebEAM"
cognito_oidc_provider_identifier = "BMW WebEAM PROD Environment"
webeam_client_id                 = "AQICAHhKCB1o5WCo3aUS95El/iBJCpqhl1tcpNYJ/yxH1DF8HgEOHQdDESQf3P8CuvpvVD2nAAAAgzCBgAYJKoZIhvcNAQcGoHMwcQIBADBsBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDKHEiiQI0bGGbXfXhQIBEIA/bFK4ewb7slOjtKqngtoGdRkfuptFhcPS2JQzwSyj2e/VdvBnDpTWO/HpSRJru6wlNRVn2fHIM5f8fLJ7Q+FP"
webeam_client_secret             = "AQICAHhKCB1o5WCo3aUS95El/iBJCpqhl1tcpNYJ/yxH1DF8HgEXg+uTxEnhLOtTvjVk1PC1AAAAhzCBhAYJKoZIhvcNAQcGoHcwdQIBADBwBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDFnzpCZV0Rdi8L51rgIBEIBDmbWAWFnZSzK4cmHzf/aNeUhqP6Yd3RZRZ2tQioOwAcrHHoTva5CDLkYSovmHpb0uqzNNKTuKQb+82JZz4+6SmWxCGA=="

cognito_client_specs = {
  allowed_oauth_flows  = ["code"]
  allowed_oauth_scopes = ["phone", "email", "openid", "aws.cognito.signin.user.admin", "profile"]
  callback_urls        = ["https://manage.aws.bmw.cloud/", "https://auth.bmwgroup.com/auth/XUI/?realm=/internetb2xmfaonly"]
  logout_urls          = ["https://manage.aws.bmw.cloud/", "https://auth.bmwgroup.com/auth/XUI/?realm=/internetb2xmfaonly"]
}

##############################################
# DYNAMODB TABLE INFORMATION
##############################################

prefix_dynamodb                         = ""
dynamodb_point_in_time_recovery_enabled = true
dynamodb_set_ttl                        = true
backup_plan_cron_expression             = "0 4 * * ? *"
replication_backup_settings = [{
  backup_plan_cold_storage_after = 30,
  backup_plan_delete_after       = 120
}]

##############################################
# IMPORT REMOTE INFORMATION
##############################################

import_prefix = "prod"

##############################################
# PORTAL FRONTEND API DEPLOYMENT INFORMATION
##############################################

# ATTENTION: value for cognito_user_pool_arn is the output value of the cognito deployment
cognito_user_pool_arn = "arn:aws-cn:cognito-idp:cn-north-1:558715975237:userpool/cn-north-1_1ixf3kxul"

lambda_logging_level                     = "DEBUG"
enable_cloudwatch_rules                  = true
lambda_trigger_dynamodb_enabled          = true
lambda_trigger_sqs_enabled               = true
lambda_max_age_for_dynamo_records_in_sec = 300
lambda_max_retry_for_dynamo_records      = 5

#3rd party
splunk_acc_queue_url              = "https://sqs.cn-north-1.amazonaws.com/104485279185/CloudPortalQueue-104485279185-cn-north-1"
four_wheels_automation_account_id = "387646815508"

##############################################
# PORTAL BACKEND DEPLOYMENT INFORMATION
##############################################

deploy_grant_purchase_role = true

##############################################
# PORTAL USER API DEPLOYMENT INFORMATION
##############################################

user_api_quota_limit = 5000

##############################################
# PORTAL CONFIG DEPLOYMENT INFORMATION
##############################################

portal_config_env        = "prod"
portal_config_env_parent = null
partition                = "aws-cn"

##############################################
# EMAIL TEMPLATES DEPLOYMENT INFORMATION
##############################################

email_templates_env    = "global"
email_templates_prefix = "email_templates"

##############################################
# EMAIL SENDING INFORMATION
##############################################

email_store_only = false
