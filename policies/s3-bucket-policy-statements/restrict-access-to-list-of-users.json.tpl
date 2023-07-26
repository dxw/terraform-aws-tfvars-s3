%{if user_ids != "[]" ~}
{
  "Effect": "Deny",
  "Principal": "*",
  "Action": "s3:*",
  "Resource": [
    "${bucket_arn}",
    "${bucket_arn}/*"
  ],
  "Condition": {
    "StringNotLike": {
      "aws:userId": ${user_ids}
    }
  }
}
%{ endif ~}
