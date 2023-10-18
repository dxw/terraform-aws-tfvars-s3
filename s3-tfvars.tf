resource "aws_s3_bucket" "tfvars" {
  bucket = "${local.project_name}-tfvars"
}

resource "aws_s3_bucket_policy" "tfvars" {
  bucket = aws_s3_bucket.tfvars.id
  policy = templatefile(
    "${path.module}/policies/s3-bucket-policy.json.tpl",
    {
      statement = <<EOT
      [
      ${templatefile("${path.module}/policies/s3-bucket-policy-statements/enforce-tls.json.tpl", {
      bucket_arn = aws_s3_bucket.tfvars.arn,
      })}${length(local.tfvars_restrict_access_user_ids) != 0 ? "," : ""}
      ${templatefile("${path.module}/policies/s3-bucket-policy-statements/restrict-access-to-list-of-users.json.tpl", {
      bucket_arn = aws_s3_bucket.tfvars.arn,
      user_ids   = jsonencode(local.tfvars_restrict_access_user_ids),
})}
      ]
      EOT
}
)
}

resource "aws_s3_bucket_public_access_block" "tfvars" {
  bucket                  = aws_s3_bucket.tfvars.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "tfvars" {
  bucket = aws_s3_bucket.tfvars.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_logging" "tfvars" {
  bucket = aws_s3_bucket.tfvars.id

  target_bucket = aws_s3_bucket.logs[0].id
  target_prefix = "s3/tfvars"
}

resource "aws_kms_key" "tfvars" {
  count = local.tfvars_kms_encryption ? 1 : 0

  description             = "This key is used to encrypt bucket objects in ${aws_s3_bucket.tfvars.id}"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "tfvars" {
  count = local.tfvars_kms_encryption ? 1 : 0

  name          = "alias/${local.project_name}-tfvars"
  target_key_id = aws_kms_key.tfvars[0].key_id
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfvars" {
  count = local.tfvars_kms_encryption ? 1 : 0

  bucket = aws_s3_bucket.tfvars.id

  dynamic "rule" {
    for_each = local.tfvars_kms_encryption ? [1] : []
    content {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.tfvars[0].arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  dynamic "rule" {
    for_each = local.tfvars_kms_encryption ? [] : [1]
    content {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}
