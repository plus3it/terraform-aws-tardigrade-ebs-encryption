# Agent Instructions

Before starting any task in this repository:

1. Run `make agents/sync`. It writes the shared Plus3 IT instructions for this repository's tardigrade-ci version to `.agents/plus3it/AGENTS.md`.
2. Read `.agents/plus3it/AGENTS.md` and follow it together with this file. If the sync fails, tell the user, and don't guess the conventions.

These rules always apply, even without the shared instructions:

- Don't push, open pull requests, publish releases, or apply infrastructure changes unless the user asks. List those steps for a person in your final report.
- Don't edit files under `.agents/plus3it/`; they are generated and overwritten by the sync.

@.agents/plus3it/AGENTS.md

## Repository-specific

### Purpose

This Terraform module turns on default EBS encryption in the current region with `aws_ebs_encryption_by_default`. By default (`create_kms_key = true`) it also creates a KMS key, with rotation enabled and an alias set by `kms_key_alias`, through the tardigrade-kms module, and sets that key as the default EBS key. The `kms_key_policy` input replaces the default key policy, and the module has no outputs.
