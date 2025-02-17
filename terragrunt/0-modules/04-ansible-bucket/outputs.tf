
output "ansible_bucket_name" {
  description = "The name of the S3 bucket storing Ansible files"
  value       = aws_s3_bucket.ansible_bucket.bucket
}

output "ansible_bucket_url" {
  description = "The URL to access the Ansible S3 bucket"
  value       = "s3://${aws_s3_bucket.ansible_bucket.bucket}"
}