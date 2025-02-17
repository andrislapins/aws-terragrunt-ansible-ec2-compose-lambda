
variable "env" {
    description = "Environment name"
    type        = string
}

variable "repo_root" {
    description = "This project's directory root path"
    type        = string
}

variable "ansible_bucket_name" {
  description = "The name of the S3 bucket to store the Ansible files"
  type        = string
}