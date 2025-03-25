terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Use variables instead of hardcoding
variable "bucket_name" {
  type = string
}

variable "versioning_enabled" {
  type    = bool
  default = false
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA6GBMFAZTZ5NBZWBS"       # ⚠️ Remove in production
  secret_key = "dk/pdDtHUvNiD8VlDIq/FfnJGgMT4RMYkYRvuFWk" # ⚠️ Remove in production
}

resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name  # ← Use Terraform variable
  
  tags = {
    Name        = var.bucket_name
    Environment = "Production"
    ManagedBy   = "Backstage"
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Disabled"  # ← Proper ternary
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
