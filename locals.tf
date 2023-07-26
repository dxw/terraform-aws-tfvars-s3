locals {
  project_name                            = var.project_name
  aws_account_id                          = data.aws_caller_identity.current.account_id
  enable_logs_bucket                      = var.enable_s3_bucket_logging
  logging_bucket_retention                = var.logging_bucket_retention
  tfvars_files                            = var.tfvars_files
  tfvars_restrict_access_user_ids         = var.tfvars_restrict_access_user_ids
  logging_bucket_restrict_access          = var.logging_bucket_restrict_access
  logging_bucket_restrict_access_user_ids = local.logging_bucket_restrict_access ? local.tfvars_restrict_access_user_ids : []
}
