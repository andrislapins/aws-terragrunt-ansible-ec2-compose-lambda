
variable "region" {
  description = "AWS region"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr_block" {
  description = "Virtual private network CIDR"
  type        = string

  validation {
    condition     = can(regex("^([0-9]{1,3}\\.){3}[0-9]{1,3}/24$", var.vpc_cidr_block))
    error_message = "The VPC CIDR block must be in the format x.x.x.x/24 (e.g., 10.0.0.0/24)"
  }
}