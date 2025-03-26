variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"  # Added default value
}

variable "versioning_enabled" {
  description = "Whether to enable versioning"
  type        = bool
  default     = false
}
