
terraform {
  source = "../../0-modules/08-ansible-compose"
}

include "prod" {
  path   = find_in_parent_folders("prod.hcl")
  expose = true
}

inputs = {
  region              = include.prod.locals.project_config.inputs.region
  project             = include.prod.locals.project_config.inputs.project
  env                 = include.prod.locals.env
  repo_root           = include.prod.locals.project_config.inputs.repo_root
  ansible_bucket_name = dependency.bucket.outputs.ansible_bucket_name
}

dependency "bucket" {
  config_path = "../04-ansible-bucket"

  mock_outputs = {
    ansible_bucket_name = "terragrunt-mock-ansible_bucket_name"
  }
}

dependency "generate" {
  config_path = "../07-generate"
}