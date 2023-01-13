terraform {

  required_version = "= 1.3.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.20.0"
    }
  }
}


provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}

provider "aws" {
  alias   = "cn-north-1"
  region  = "cn-north-1"
  profile = var.aws_profile
}
