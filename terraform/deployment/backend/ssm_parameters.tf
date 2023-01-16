
module "traffic_config_param" {
  source = "../../modules/ssm_parameter"

  parameter_name        = "${local.parameter_prefix}${var.ssm_parameter_traffic_config}"
  parameter_description = "API contract data for Mailtools ticket creation"
  parameter_value = jsonencode(
    {
      "name": "group_PE",
      "ping_ips": [
        "192.168.201.34",
        "192.168.201.30"
      ],
      "acl_id": "acl-0d5098dea8ba07575"
    }
  )
  tags = var.tags
}

#
#module "itsm_param" {
#  source = "../../modules/ssm_parameter"
#
#  parameter_name        = "${local.parameter_prefix}${var.ssm_parameter_itsm_contract_data}"
#  parameter_description = "ITSM contract data for ticket creation"
#  parameter_value = jsonencode(
#    {
#      "api_endpoint" : "replaceme",
#      "api_key" : "replaceme",
#      "contract_id" : "replaceme",
#      "event_id" : "replaceme",
#      "appd_id" : "replaceme",
#      "dry_run" : true
#    }
#  )
#
#  tags = var.tags
#}
#module "tufin_param" {
#  source = "../../modules/ssm_parameter"
#
#  parameter_name        = "${local.parameter_prefix}${var.ssm_parameter_tufin_data}"
#  parameter_description = "TUFIN contract data for VPC decommission"
#  parameter_value = jsonencode(
#    {
#      "api_endpoint" : "replaceme",
#      "delete_path" : "/ps/api/v1/subnet-decommissioning",
#      "user" : "replaceme",
#      "pwd" : "replaceme",
#      "verify" : false
#    }
#  )
#
#  tags = var.tags
#}
#
#module "sbus_param" {
#  source = "../../modules/ssm_parameter"
#
#  parameter_name        = "${local.parameter_prefix}${var.ssm_parameter_sbus_contract_data}"
#  parameter_description = "SBUS contract data for cloudroom creation, application relation and network relation"
#  parameter_value = jsonencode(
#    {
#      "url" : "https://sbus-i.bmwgroup.net/sbus/HTTPGenericRequest/",
#      "verify" : false
#    }
#  )
#
#  tags = var.tags
#}
#
#module "sbus_token_param" {
#  source = "../../modules/ssm_parameter"
#
#  parameter_name        = "${local.parameter_prefix}${var.ssm_parameter_sbus_token_contract_data}"
#  parameter_description = "SBUS token contract data to retrieve access token"
#  parameter_value = jsonencode(
#    {
#      "url" : "https://auth-i.bmwgroup.net/auth/",
#      "client_credentials_m2m" : {
#        "client_id" : "c20dfd36-df28-4edb-82b4-a0eafd145a86",
#        "client_secret" : "REPLACEME",
#        "scope" : "machine2machine"
#      },
#      "endpoints" : {
#        "access_token" : "oauth2/realms/root/realms/machine2machine/access_token",
#        "token_info" : "oauth2/realms/root/realms/machine2machine/tokeninfo",
#        "introspect" : "oauth2/realms/root/realms/machine2machine/introspect"
#      }
#    }
#  )
#
#  tags = var.tags
#}
#
#
#module "bmw_mail_param" {
#  source = "../../modules/ssm_parameter"
#
#  parameter_name        = "${local.parameter_prefix}${var.ssm_parameter_bmw_internal_mail}"
#  parameter_description = "API contract data for Mailtools ticket creation"
#  parameter_value = jsonencode(
#    {
#      "smtp" : "mail.bmwgroup.net",
#      "port" : 587,
#      "username" : "",
#      "password" : ""
#    }
#  )
#  parameter_type = "SecureString"
#
#  tags = var.tags
#}
