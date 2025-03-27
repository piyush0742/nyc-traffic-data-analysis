# Note: QuickSight setup is complex and may require manual steps
# This provides basic configuration but may need adjustment

# IAM policy for QuickSight
resource "aws_iam_policy" "quicksight_policy" {
  name        = "${local.name_prefix}-quicksight-policy"
  description = "Policy for QuickSight to access Athena and S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "athena:*",
          "glue:GetDatabase",
          "glue:GetDatabases",
          "glue:GetTable",
          "glue:GetTables",
          "glue:GetPartition",
          "glue:GetPartitions"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetBucketLocation",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:ListBucketMultipartUploads",
          "s3:ListMultipartUploadParts",
          "s3:AbortMultipartUpload",
          "s3:CreateBucket",
          "s3:PutObject"
        ]
        Resource = [
          aws_s3_bucket.raw_data.arn,
          "${aws_s3_bucket.raw_data.arn}/*",
          aws_s3_bucket.cleaned_data.arn,
          "${aws_s3_bucket.cleaned_data.arn}/*"
        ]
      }
    ]
  })
}

# QuickSight user (may need to be created manually)
# Note: QuickSight resources are region-specific and may require AWS CLI setup