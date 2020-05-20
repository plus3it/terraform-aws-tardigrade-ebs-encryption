provider "aws" {}

##### LOCALS #####
locals {
  # kms integration
  kms_key_id     = var.create_kms_key ? module.kms.keys[var.kms_key_alias].arn : ""
  kms_key_policy = var.create_kms_key && var.kms_key_policy == null ? data.aws_iam_policy_document.this[0].json : var.kms_key_policy

  keys = [
    {
      alias               = var.kms_key_alias,
      description         = var.kms_key_alias,
      policy              = local.kms_key_policy,
      enable_key_rotation = true
    }
  ]
}

##### RESOURCES #####
module "kms" {
  source = "git::https://github.com/plus3it/terraform-aws-tardigrade-kms.git?ref=0.0.2"

  providers = {
    aws = aws
  }

  create_keys = var.create_kms_key
  keys        = local.keys
}

resource "aws_ebs_encryption_by_default" "this" {
  count = var.create_ebs_encryption ? 1 : 0

  enabled = true
}

resource "aws_ebs_default_kms_key" "this" {
  count = var.create_ebs_encryption && var.create_kms_key ? 1 : 0

  key_arn = local.kms_key_id
}

##### DATA SOURCES #####
data "aws_region" "this" {
  count = var.create_ebs_encryption ? 1 : 0
}

data "aws_caller_identity" "this" {
  count = var.create_ebs_encryption ? 1 : 0
}

data "aws_partition" "this" {
  count = var.create_ebs_encryption ? 1 : 0
}

data "aws_iam_policy_document" "this" {
  count = var.create_ebs_encryption && var.create_kms_key ? 1 : 0

  statement {
    sid = "Allow access through EBS for all principals in the account that are authorized to use EBS"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:CreateGrant",
      "kms:DescribeKey"
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"

      values = [
        "ec2.${data.aws_region.this[0].name}.amazonaws.com"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "kms:CallerAccount"

      values = [
        "${data.aws_caller_identity.this[0].account_id}"
      ]
    }

    resources = ["*"]
  }

  statement {
    sid = "Allow direct access to key metadata to the account"
    actions = [
      "kms:Describe*",
      "kms:Get*",
      "kms:List*",
      "kms:RevokeGrant"
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:${data.aws_partition.this[0].partition}:iam::${data.aws_caller_identity.this[0].account_id}:root"]
    }

    resources = ["*"]
  }

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
      identifiers = ["arn:${data.aws_partition.this[0].partition}:iam::${data.aws_caller_identity.this[0].account_id}:root"]
    }

    resources = ["*"]
  }
}
