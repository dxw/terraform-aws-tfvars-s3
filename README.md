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
  source  = "github.com/dxw/terraform-aws-tfvars-s3?ref=v0.1.0"

  project_name             = "my-project"
  # enable_s3_bucket_logging = true
  # logging_bucket_retention = true
  # tfvars_files             = {}
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.3 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.8.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.8.0 |

## Resources

| Name | Type |
|------|------|
| [aws_kms_alias.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_alias.tfvars](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_alias) | resource |
| [aws_kms_key.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.tfvars](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_s3_bucket.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket.tfvars](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_lifecycle_configuration.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_logging.tfvars](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_logging) | resource |
| [aws_s3_bucket_policy.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.tfvars](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_public_access_block.tfvars](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.tfvars](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_bucket_versioning.tfvars](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_s3_object.tfvar_file](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_s3_bucket_logging"></a> [enable\_s3\_bucket\_logging](#input\_enable\_s3\_bucket\_logging) | Enable S3 bucket logging | `bool` | `true` | no |
| <a name="input_logging_bucket_retention"></a> [logging\_bucket\_retention](#input\_logging\_bucket\_retention) | Logging bucket retention in days. Set to 0 to keep all logs. | `number` | `30` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project name to be used as a prefix for all resources | `string` | n/a | yes |
| <a name="input_tfvars_files"></a> [tfvars\_files](#input\_tfvars\_files) | Map of objects containing tfvar file paths | <pre>map(<br>    object({<br>      path = string<br>      }<br>  ))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
