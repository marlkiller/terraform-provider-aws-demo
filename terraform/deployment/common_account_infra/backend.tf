# The "backend" is the interface that Terraform uses to store state,
# perform operations, etc. If this message is showing up, it means that the
# Terraform configuration you're using is using a custom configuration for
# the Terraform backend.

terraform {
  backend "s3" {}
}
