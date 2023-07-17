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
