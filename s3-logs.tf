# https://github.com/aquasecurity/tfsec/issues/2081
# tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "logs" {
  count = local.enable_logs_bucket ? 1 : 0

  bucket = "${local.project_name}-tfvars-logs"
}

resource "aws_s3_bucket_policy" "logs" {
  count = local.enable_logs_bucket ? 1 : 0

  bucket = aws_s3_bucket.logs[0].id
  policy = templatefile(
    "${path.module}/policies/s3-bucket-policy.json.tpl",
    {
      statement = <<EOT
      [
      ${templatefile("${path.module}/policies/s3-bucket-policy-statements/enforce-tls.json.tpl", { bucket_arn = aws_s3_bucket.logs[0].arn })},
      ${templatefile("${path.module}/policies/s3-bucket-policy-statements/log-delivery-access.json.tpl", {
      log_bucket_arn     = aws_s3_bucket.logs[0].arn
      source_bucket_arns = jsonencode([aws_s3_bucket.tfvars.arn])
      account_id         = local.aws_account_id
      })}${length(local.tfvars_restrict_access_user_ids) != 0 ? "," : ""}
      ${templatefile("${path.module}/policies/s3-bucket-policy-statements/restrict-access-to-list-of-users.json.tpl", {
      bucket_arn = aws_s3_bucket.logs[0].arn,
      user_ids   = jsonencode(local.logging_bucket_restrict_access_user_ids),
})}
      ]
      EOT
}
)
}

resource "aws_s3_bucket_public_access_block" "logs" {
  count = local.enable_logs_bucket ? 1 : 0

  bucket                  = aws_s3_bucket.logs[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "logs" {
  count = local.enable_logs_bucket ? 1 : 0

  bucket = aws_s3_bucket.logs[0].id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_kms_key" "logs" {
  count = local.enable_logs_bucket ? 1 : 0

  description             = "This key is used to encrypt bucket objects in ${aws_s3_bucket.logs[0].id}"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "logs" {
  count = local.enable_logs_bucket ? 1 : 0

  name          = "alias/${local.project_name}-tfvars-logs"
  target_key_id = aws_kms_key.logs[0].key_id
}


resource "aws_s3_bucket_server_side_encryption_configuration" "logs" {
  count = local.enable_logs_bucket ? 1 : 0

  bucket = aws_s3_bucket.logs[0].id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.logs[0].arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "logs" {
  count = local.enable_logs_bucket && local.logging_bucket_retention != 0 ? 1 : 0

  bucket = aws_s3_bucket.logs[0].id

  rule {
    id = "all_expire"

    filter {
      prefix = ""
    }

    expiration {
      days = local.logging_bucket_retention
    }

    status = "Enabled"
  }
}
