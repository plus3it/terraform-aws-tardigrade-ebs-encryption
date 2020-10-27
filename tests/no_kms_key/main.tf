provider "aws" {
  region = "us-east-1"
}

module "create_ebs_encryption" {
  source = "../../"

  create_kms_key = false
}
