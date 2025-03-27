# Glue database
resource "aws_glue_catalog_database" "data_pipeline_db" {
  name = "${local.name_prefix}_database"
}

# Glue crawler for raw data
resource "aws_glue_crawler" "raw_data_crawler" {
  name          = "${local.name_prefix}-raw-data-crawler"
  database_name = aws_glue_catalog_database.data_pipeline_db.name
  role          = aws_iam_role.glue_role.arn
  schedule      = var.glue_crawler_schedule

  s3_target {
    path = "s3://${aws_s3_bucket.raw_data.bucket}"
  }

  configuration = jsonencode({
    Version = 1.0
    CrawlerOutput = {
      Partitions = { AddOrUpdateBehavior = "InheritFromTable" }
    }
    Grouping = {
      TableGroupingPolicy = "CombineCompatibleSchemas"
    }
  })

  tags = {
    Name        = "${local.name_prefix}-raw-data-crawler"
    Environment = var.environment
  }
}

# Glue crawler for cleaned data
resource "aws_glue_crawler" "cleaned_data_crawler" {
  name          = "${local.name_prefix}-cleaned-data-crawler"
  database_name = aws_glue_catalog_database.data_pipeline_db.name
  role          = aws_iam_role.glue_role.arn
  schedule      = var.glue_crawler_schedule

  s3_target {
    path = "s3://${aws_s3_bucket.cleaned_data.bucket}"
  }

  configuration = jsonencode({
    Version = 1.0
    CrawlerOutput = {
      Partitions = { AddOrUpdateBehavior = "InheritFromTable" }
    }
    Grouping = {
      TableGroupingPolicy = "CombineCompatibleSchemas"
    }
  })

  tags = {
    Name        = "${local.name_prefix}-cleaned-data-crawler"
    Environment = var.environment
  }
}