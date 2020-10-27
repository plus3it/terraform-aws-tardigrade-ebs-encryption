# terraform-aws-tardigrade-ebs-encryption

Terraform module to setup default ebs encryption

<!-- BEGIN TFDOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_kms\_key | Controls whether to create a kms key for the ebs encryption | `bool` | `true` | no |
| kms\_key\_alias | (Optional) The display name of the kms key | `string` | `"terraform-ebs-encryption-kms-key"` | no |
| kms\_key\_policy | (Optional) Key policy to use when creating a kms key. If no policy is provided, a default policy will be used. | `string` | `null` | no |

## Outputs

No output.

<!-- END TFDOCS -->
