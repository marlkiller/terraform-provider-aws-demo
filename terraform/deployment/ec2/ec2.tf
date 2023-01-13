module "ec2" {
  source               = "../../modules/ec2"
  instance_type        = var.instance_type
  ec2_subnet_id        = var.ec2_subnet_id
  ami                  = var.ami
  for_each             = toset(["one", "two"])
  #  for_each = toset(["one"])
  instance_name        = "${var.instance_name}_${each.key}"
  # AWS SSM support : AmazonSSMRoleForInstancesQuickSetup 
  iam_instance_profile = var.iam_instance_profile
}