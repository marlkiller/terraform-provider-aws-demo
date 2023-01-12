output "lambda_role" {
  value = module.iam.lambda_role
}
#
#output "nuke_account_role" {
#  value = module.iam.nuke_account_role
#}
#
#output "api_gateway_role" {
#  value = module.iam.api_gateway_role
#}
#
#output "stepfunction_role" {
#  value = module.iam.stepfunction_role
#}
#
#output "resource_bucket" {
#  value = {
#    arn    = aws_s3_bucket.portal_resources[0].arn,
#    id     = aws_s3_bucket.portal_resources[0].id,
#    bucket = aws_s3_bucket.portal_resources[0].bucket
#  }
#}
#
#output "ad_credentials_ssm_parameter_name" {
#  value = module.ad_param.name
#}
#
#output "cloud_next_configuration_ssm_parameter_name" {
#  value = module.cloud_next_configuration.name
#}
#
#output "lambda_subnet_ids" {
#  value = tolist(data.aws_subnets.lambda.ids)
#}
#
#output "lambda_security_group_id" {
#  value = aws_security_group.lambda.id
#}

#output "open_search" {
#  value = var.deploy_open_search ? {
#    domain_name        = module.open_search_domain[var.prefix].cluster.name
#    domain_endpoint    = module.open_search_domain[var.prefix].cluster.endpoint
#    dashboard_endpoint = "${module.open_search_domain[var.prefix].cluster.endpoint}/_dashboards/"
#    kibana_endpoint    = module.open_search_domain[var.prefix].cluster.kibana_endpoint
#    } : {
#    domain_name        = "<name>"
#    domain_endpoint    = "<endpoint>"
#    dashboard_endpoint = "<endpoint>/_dashboards/"
#    kibana_endpoint    = "<endpoint>/kibana"
#  }
#}
