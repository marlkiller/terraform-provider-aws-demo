resource "aws_instance" "item_instance" {
  ami                  = var.ami
  instance_type        = var.instance_type
  subnet_id            = var.ec2_subnet_id
  iam_instance_profile = var.iam_instance_profile
  tags                 = {
    Name = var.instance_name
  }
  #  tags        = merge({ "Name" = var.name }, var.tags)

}