terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


resource "aws_s3_bucket" "this" {
  bucket = "${{ values.bucket_name }}"
  
  tags = {
    Name        = "${{ values.bucket_name }}"
    Environment = "Production"
    ManagedBy   = "Backstage"
  }
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id
  versioning_configuration {
    status = "${{ values.versioning ? 'Enabled' : 'Disabled' }}"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
