#data "terraform_remote_state" "cognito" {
#  backend = "s3"
#
#  config = {
#    region  = data.aws_region.current.name
#    bucket  = "tf-state-${data.aws_caller_identity.current.account_id}-${data.aws_region.current.name}"
#    key     = "traffic-network/${var.import_prefix}/${data.aws_region.current.name}/cognito.tfstate"
#    profile = "${data.aws_caller_identity.current.account_id}_UserFull"
#  }
#}
