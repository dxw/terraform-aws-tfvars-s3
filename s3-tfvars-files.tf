resource "aws_s3_object" "tfvar_file" {
  for_each = local.tfvars_files

  bucket      = aws_s3_bucket.tfvars.id
  key         = each.value["key"] == "" ? each.value["path"] : each.value["key"]
  source      = each.value["path"]
  source_hash = filemd5(each.value["path"])
  kms_key_id  = local.tfvars_kms_encryption ? aws_kms_key.tfvars[0].arn : null
}
