terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  access_key = "AKIA3IJ74JHWC62ZBTCH"       # Hardcoded credentials (INSECURE)
  secret_key = "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" # Hardcoded credentials (INSECURE)
}

resource "aws_s3_bucket" "this" {
  bucket = "my-unique-bucket-name-12345"  # Hardcoded bucket name

  tags = {
    Name        = "my-production-bucket"
    Environment = "Production"
    ManagedBy   = "Backstage"
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "Enabled"  # Hardcoded versioning setting
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
