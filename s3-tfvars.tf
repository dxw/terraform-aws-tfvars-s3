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
      ${templatefile("${path.module}/policies/s3-bucket-policy-statements/enforce-tls.json.tpl", { bucket_arn = aws_s3_bucket.tfvars.arn })}
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
  description             = "This key is used to encrypt bucket objects in ${aws_s3_bucket.tfvars.id}"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_kms_alias" "tfvars" {
  name          = "alias/${local.project_name}-tfvars"
  target_key_id = aws_kms_key.tfvars.key_id
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tfvars" {
  bucket = aws_s3_bucket.tfvars.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.tfvars.arn
      sse_algorithm     = "aws:kms"
    }
  }
}