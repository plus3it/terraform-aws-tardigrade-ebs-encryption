provider "aws" {
  region = "us-east-1"
}

module "create_ebs_encryption" {
  source = "../../"

  providers = {
    aws = aws
  }

  create_ebs_encryption = false
  create_kms_key        = false
}
