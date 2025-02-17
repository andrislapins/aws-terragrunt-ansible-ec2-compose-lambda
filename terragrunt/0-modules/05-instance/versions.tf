
terraform {
  required_version = "~> 1.10"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
    external = {
      source = "hashicorp/external"
      version = "~> 2"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~> 4"
    }
    local = {
      source = "hashicorp/local"
      version = "~> 2"
    }
  }
}