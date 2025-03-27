variable "aws_region" {
  description = "AWS region to deploy resources"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project for resource naming"
  default     = "data-pipeline"
}

variable "environment" {
  description = "Environment (dev/stage/prod)"
  default     = "dev"
}

variable "ec2_instance_type" {
  description = "Instance type for the EC2"
  default     = "t3.micro"
}

variable "github_repo" {
  description = "GitHub repository URL for the Python scripts"
  type        = string
}

variable "python_script_path" {
  description = "Path to the Python script in the GitHub repo"
  default     = "scripts/data_fetcher.py"
}

variable "glue_crawler_schedule" {
  description = "Schedule for the Glue crawler"
  default     = "cron(0 12 * * ? *)" # Runs daily at 12:00 UTC
}