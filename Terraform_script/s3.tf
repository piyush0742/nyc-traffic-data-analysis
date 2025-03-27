# S3 bucket for raw data
resource "aws_s3_bucket" "raw_data" {
  bucket = "${local.name_prefix}-raw-data"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  lifecycle_rule {
    id      = "raw-data-lifecycle"
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }
  }

  tags = {
    Name        = "${local.name_prefix}-raw-data"
    Environment = var.environment
  }
}

# S3 bucket for cleaned data
resource "aws_s3_bucket" "cleaned_data" {
  bucket = "${local.name_prefix}-cleaned-data"
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "${local.name_prefix}-cleaned-data"
    Environment = var.environment
  }
}