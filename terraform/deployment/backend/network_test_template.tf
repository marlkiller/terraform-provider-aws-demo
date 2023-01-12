#resource "aws_s3_object" "network_test_cfn_template" {
#  depends_on = [module.backend_s3]
#
#  bucket = local.backend_s3
#  key    = "cfn-templates/network_test_cfn_template.yaml"
#  source = "${path.module}/../../data/cfn_templates/network_test_cfn_template.yaml"
#  etag   = filemd5("${path.module}/../../data/cfn_templates/network_test_cfn_template.yaml")
#}
