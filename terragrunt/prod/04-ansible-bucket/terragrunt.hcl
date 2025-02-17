
terraform {
  source = "../../0-modules/04-ansible-bucket"
}

include "prod" {
  path   = find_in_parent_folders("prod.hcl")
  expose = true
}

inputs = {
  region    = include.prod.locals.project_config.inputs.region
  project   = include.prod.locals.project_config.inputs.project
  env       = include.prod.locals.env
  repo_root = include.prod.locals.project_config.inputs.repo_root
}