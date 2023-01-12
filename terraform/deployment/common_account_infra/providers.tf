terraform {

  required_version = "= 1.3.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.19.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.1"
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
