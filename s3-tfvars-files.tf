resource "aws_s3_object" "tfvar_file" {
  for_each = local.tfvars_files

  bucket     = aws_s3_bucket.tfvars.id
  key        = each.value["path"]
  source     = each.value["path"]
  kms_key_id = aws_kms_key.tfvars.key_id
}
