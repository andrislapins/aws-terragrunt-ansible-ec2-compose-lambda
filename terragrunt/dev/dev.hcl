
locals {
  project_config = read_terragrunt_config(find_in_parent_folders("project_config.hcl"))
  env            = "dev"
}

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket         = "terraform-state-${local.env}-${local.project_config.inputs.aws_account}"
    dynamodb_table = "terraform-state-${local.env}-lock-dynamodb-${local.project_config.inputs.aws_account}"
    encrypt        = true
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.project_config.inputs.region
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
provider "aws" {
    region = "${local.project_config.inputs.region}"
}
EOF
}