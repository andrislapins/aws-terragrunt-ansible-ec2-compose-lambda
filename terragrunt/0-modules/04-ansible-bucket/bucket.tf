
### An S3 bucket to store Ansible playbook for configuring EC2 instance on itself

resource "random_string" "ansible_bucket_suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "aws_s3_bucket" "ansible_bucket" {
  bucket = "${var.project}-${var.env}-ansible-${random_string.ansible_bucket_suffix.result}"
}