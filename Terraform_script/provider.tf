provider "aws" {
  region = var.aws_region
}


locals {
  name_prefix = "${var.project_name}-${var.environment}"
}