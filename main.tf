provider "aws" {}

data "aws_caller_identity" "_" {}
data "aws_region" "_" {}


locals {
  name_suffix = format("terraform-remote-state-%s-%s", data.aws_region._.name, data.aws_caller_identity._.id)
}


resource "aws_kms_key" "encrypt_key" {
}

resource "aws_s3_bucket" "bucket" {
  depends_on = [
    aws_kms_key.encrypt_key]
  bucket = format("s3-%s", local.name_suffix)
  region = data.aws_region._.name
  tags = var.tags

  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.encrypt_key.arn
        sse_algorithm = "aws:kms"
      }
    }
  }
}

resource "aws_dynamodb_table" "lock_table" {
  name = format("dynamodb-%s", local.name_suffix)
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
  tags = var.tags
}
