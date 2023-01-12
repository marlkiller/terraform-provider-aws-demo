#locals {
#  full_state_machine_specs = {
#    grant-temporary-access = {
#      role_arn = data.terraform_remote_state.common_account_infra.outputs.stepfunction_role.arn,
#      definition = templatefile("../../data/step_functions/grant_temporary_access.json", {
#        create_orders_arn = module.lambda_functions.functions["create-orders"].arn
#      })
#    }
#    grant-purchase-role = var.deploy_grant_purchase_role ? {
#      role_arn = data.terraform_remote_state.common_account_infra.outputs.stepfunction_role.arn,
#      definition = templatefile("../../data/step_functions/grant_purchase_role.json", {
#        create_orders_arn                      = module.lambda_functions.functions["create-orders"].arn,
#        purchase_role_name                     = "BMWPurchasing",
#        order_information_table_name           = local.dynamodb_tables["order-information"].id,
#        step_function_helper_arn               = module.lambda_functions.functions["step-function-helper"].arn,
#        audit_table_name                       = local.dynamodb_tables["audit-information"].id,
#        finalize_grant_purchase_role_order_arn = module.lambda_functions.functions["finalize-grant-purchase-role-order"].arn
#      })
#    } : null
#    network-test = {
#      role_arn = data.terraform_remote_state.common_account_infra.outputs.stepfunction_role.arn,
#      definition = templatefile("../../data/step_functions/network_test.json", {
#        network_test_handler_arn = module.lambda_functions.functions["network-tests-handler"].arn
#        step_function_helper_arn = module.lambda_functions.functions["step-function-helper"].arn,
#        prefix                   = var.prefix
#        import_prefix            = var.import_prefix
#      })
#    }
#  }
#}
#
#module "portal_step_functions" {
#  source = "../../modules/step_functions"
#  prefix = var.prefix
#  tags   = var.tags
#
#  state_machine_specs = {
#    for key, spec in local.full_state_machine_specs :
#    key => spec
#    if spec != null
#  }
#}
