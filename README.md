# Terraform AWS Tfvars S3

[![Terraform CI](https://github.com/dxw/terraform-aws-tfvars-s3/actions/workflows/continuous-integration-terraform.yml/badge.svg?branch=main)](https://github.com/dxw/terraform-aws-tfvars-s3/actions/workflows/continuous-integration-terraform.yml?branch=main)
[![GitHub release](https://github.com/dxw/terraform-aws-tfvars-s3/releases)](https://github.com/dxw/terraform-aws-tfvars-s3/releases)

This module creates and manages an S3 bucket that will be used to upload tfvars
to, so that they can be shared with other people developing on a Terraform
managed project.

## Usage

Example module usage:

```hcl
module "aws_tfvars_s3" {
  source  = "github.com/dxw/terraform-aws-tfvars-s3?ref=main"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.3 |

## Providers

No providers.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->
