module "create_ebs_encryption" {
  source = "../../"

  create_kms_key = false
}
