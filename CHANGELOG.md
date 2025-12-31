## terraform-aws-tardigrade-ebs-encryption Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/) and this project adheres to [Semantic Versioning](http://semver.org/).

### [3.0.0](https://github.com/plus3it/terraform-aws-tardigrade-ebs-encryption/releases/tag/3.0.0)

**Released**: 2025.12.30

**Summary**:

*   Addresses deprecation warning for aws_region "name" attribute

### [2.0.0](https://github.com/plus3it/terraform-aws-tardigrade-ebs-encryption/releases/tag/2.0.0)

**Commit Delta**: N/A

**Released**: 2021.10.07

**Summary**:

*   Uses count to disable kms module, since the prior mechanism using the `create_keys`
    argument was deprecated in v2 of the kms module. This requires `state mv` when
    updating to v2 of the ebs-encryption module.

### [0.0.0](https://github.com/plus3it/terraform-aws-tardigrade-ebs-encryption/releases/tag/0.0.0)

**Commit Delta**: N/A

**Released**: 2020.05.19

**Summary**:

*   Initial release!
