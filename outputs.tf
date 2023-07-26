output "aws_s3_bucket_tfvars" {
  value = aws_s3_bucket.tfvars
}

output "aws_kms_key_tfvars" {
  value = aws_kms_key.tfvars
}

output "aws_kms_alias_tfvars" {
  value = aws_kms_alias.tfvars
}

output "aws_s3_bucket_logs" {
  value = local.enable_logs_bucket ? aws_s3_bucket.logs[0] : null
}

output "aws_kms_key_logs" {
  value = local.enable_logs_bucket ? aws_kms_key.logs[0] : null
}

output "aws_kms_alias_logs" {
  value = local.enable_logs_bucket ? aws_kms_alias.logs[0] : null
}
