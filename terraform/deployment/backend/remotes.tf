data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "terraform_remote_state" "common_account_infra" {
  backend = "s3"

  config = {
    region  = data.aws_region.current.name
    bucket  = "tf-state-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
    key     = "traffic-network/${var.import_prefix}/${data.aws_region.current.name}/common_account_infra.tfstate"
    profile = "${data.aws_caller_identity.current.account_id}_UserFull"
  }
}

#data "terraform_remote_state" "datastores" {
#  backend = "s3"
#
#  config = {
#    region  = data.aws_region.current.name
#    bucket  = "tf-state-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
#    key     = "traffic-network/${var.prefix}/${data.aws_region.current.name}/dynamodb.tfstate"
#    profile = "${data.aws_caller_identity.current.account_id}_UserFull"
#  }
#}

#data "terraform_remote_state" "lambda_layers" {
#  backend = "s3"
#
#  config = {
#    region  = data.aws_region.current.name
#    bucket  = "tf-state-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
#    key     = "traffic-network/${var.prefix}/${data.aws_region.current.name}/lambda_layers.tfstate"
#    profile = "${data.aws_caller_identity.current.account_id}_UserFull"
#  }
#}
