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

data "aws_s3_buckets" "current" {}

output "bucket_list" {
  value = data.aws_s3_buckets.current.buckets[*].name
}
