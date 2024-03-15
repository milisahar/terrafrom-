provider "aws" {
  region = "eu-west-1"
  profile = "AdministratorAccess-529219089249"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.40.0"
    }
  }
}
