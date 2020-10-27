variable "create_kms_key" {
  description = "Controls whether to create a kms key for the ebs encryption"
  type        = bool
  default     = true
}

variable "kms_key_alias" {
  description = "(Optional) The display name of the kms key"
  type        = string
  default     = "terraform-ebs-encryption-kms-key"
}

variable "kms_key_policy" {
  description = "(Optional) Key policy to use when creating a kms key. If no policy is provided, a default policy will be used."
  type        = string
  default     = null
}
