variable "region" {
  description = "AWS region"
  type        = string
}

variable "s3_bucket_name" {
  type = string
}

variable "versioning" {
  description = "Whether to enable versioning"
  type        = bool
  default     = false
}
