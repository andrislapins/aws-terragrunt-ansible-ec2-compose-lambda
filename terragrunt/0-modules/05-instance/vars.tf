
variable "project" {
    description = "Project name"
    type        = string
}

variable "env" {
    description = "Environment name"
    type        = string
}

variable "repo_root" {
    description = "This project's directory root path"
    type        = string
}

variable "ec2_instance_name" {
    description = "Name of the EC2 instance"
    type        = string
}

variable "ec2_instance_disk_size" {
    description = "Disk size of the EC2 instance"
    type        = number
}

variable "ec2_instance_type" {
    description = "Instance type of the EC2 instance"
    type        = string
}