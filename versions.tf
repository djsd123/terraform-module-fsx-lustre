terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "local" {}

  required_version = ">= 1.2.0, < 2.0.0"
}

provider "aws" {
  region                      = "eu-west-1"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  access_key                  = "mock_access_key"
  secret_key                  = "mock_secret_key"

  default_tags {
    tags = {
      Terraform = true
      Repo      = "terraform-module-fsx-lustre"
    }
  }
}
