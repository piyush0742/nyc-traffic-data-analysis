output "raw_data_bucket_name" {
  value = aws_s3_bucket.raw_data.bucket
}

output "cleaned_data_bucket_name" {
  value = aws_s3_bucket.cleaned_data.bucket
}

output "glue_database_name" {
  value = aws_glue_catalog_database.data_pipeline_db.name
}

output "athena_workgroup_name" {
  value = aws_athena_workgroup.data_pipeline.name
}

output "ec2_public_dns" {
  value = aws_instance.data_pipeline.public_dns
}

output "ec2_ssh_command" {
  value = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.data_pipeline.public_dns}"
}