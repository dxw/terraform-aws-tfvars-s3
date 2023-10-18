variable "project_name" {
  description = "Project name to be used as a prefix for all resources"
  type        = string
}

variable "enable_s3_bucket_logging" {
  description = "Enable S3 bucket logging"
  type        = bool
  default     = true
}

variable "logging_bucket_retention" {
  description = "Logging bucket retention in days. Set to 0 to keep all logs."
  type        = number
  default     = 30
}

variable "tfvars_files" {
  description = "Map of objects containing tfvar file paths"
  type = map(
    object({
      path = string
      key  = optional(string, "")
      }
  ))
  default = {}
}

variable "tfvars_restrict_access_user_ids" {
  description = "List of AWS User IDs that require access to the tfvars S3 bucket. If left empty, all users within the AWS account will have access"
  type        = list(string)
  default     = []
}

variable "tfvars_kms_encryption" {
  description = "Use KMS rather than AES256 encryption for the tfvars bucket"
  type        = bool
  default     = true
}
