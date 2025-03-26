terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
  access_key = "AKIA3IJ74JHWC62ZBTCH"
  secret_key = "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"
}

resource "aws_s3_bucket" "this" {
  bucket = "my-unique-bucket-name-12345-naren"

  tags = {
    Name        = "my-production-bucket"
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
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
