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
  access_key = "AKIA3IJ74JHWC62ZBTCH"
  secret_key = "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"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-unique-bucket-name-${formatdate("YYYYMMDDhhmmss", timestamp())}"  
  # Using timestamp to ensure unique name

  tags = {
    Name        = "MyBackstageBucket"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.my_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

output "bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}
