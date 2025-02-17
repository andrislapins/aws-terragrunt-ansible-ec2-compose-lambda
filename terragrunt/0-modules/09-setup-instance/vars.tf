
variable "aws_account_id" {
    description = "AWS account ID"
    type        = string
}

variable "region" {
    description = "AWS region"
    type        = string
}

variable "ec2_instance_name" {
    description = "Name of the EC2 instance"
    type        = string
}

variable "ansible_bucket_name" {
  description = "The name of the S3 bucket to store the Ansible files"
  type        = string
}