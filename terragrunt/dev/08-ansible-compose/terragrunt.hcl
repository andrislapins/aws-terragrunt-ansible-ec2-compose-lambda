
terraform {
  source = "../../0-modules/08-ansible-compose"
}

include "dev" {
  path   = find_in_parent_folders("dev.hcl")
  expose = true
}

inputs = {
  region              = include.dev.locals.project_config.inputs.region
  project             = include.dev.locals.project_config.inputs.project
  env                 = include.dev.locals.env
  repo_root           = include.dev.locals.project_config.inputs.repo_root
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