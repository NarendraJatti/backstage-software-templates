terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

variable "bucket_name" {
  type = string
}

variable "s3_bucket_name" {
  type = string
}

variable "versioning_enabled" {
  type    = bool
  default = false
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA3IJ74JHWC62ZBTCH"       # ⚠️ Exposed for testing purposes
  secret_key = "ZWGpVFK43DzIob8KEIAbpK6T99XzLmCmGVXFC9RG" # ⚠️ Exposed for testing purposes
}

resource "aws_s3_bucket" "this" {
  bucket = var.s3_bucket_name
  
  tags = {
    Name        = var.bucket_name
    Environment = "Production"
    ManagedBy   = "Backstage"
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = var.versioning_enabled ? "Enabled" : "Disabled"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
