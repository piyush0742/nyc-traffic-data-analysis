# Athena workgroup
resource "aws_athena_workgroup" "data_pipeline" {
  name = "${local.name_prefix}-workgroup"

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = true

    result_configuration {
      output_location = "s3://${aws_s3_bucket.cleaned_data.bucket}/athena_results/"

      encryption_configuration {
        encryption_option = "SSE_S3"
      }
    }
  }

  tags = {
    Name        = "${local.name_prefix}-athena-workgroup"
    Environment = var.environment
  }
}