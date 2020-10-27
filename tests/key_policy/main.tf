provider "aws" {
  region = "us-east-1"
}

module "create_ebs_encryption" {
  source = "../../"

  providers = {
    aws = aws
  }

  create_kms_key        = true
  kms_key_policy        = data.aws_iam_policy_document.this.json
}

data "aws_region" "this" {}

data "aws_caller_identity" "this" {}

data "aws_partition" "this" {}

data "aws_iam_policy_document" "this" {
  statement {
    sid = "Allow administration of the key"
    actions = [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion"
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:${data.aws_partition.this.partition}:iam::${data.aws_caller_identity.this.account_id}:root"]
    }

    resources = ["*"]
  }
}
