
terraform {
  source = "../../0-modules/04-ansible-bucket"
}

include "dev" {
  path   = find_in_parent_folders("dev.hcl")
  expose = true
}

inputs = {
  region    = include.dev.locals.project_config.inputs.region
  project   = include.dev.locals.project_config.inputs.project
  env       = include.dev.locals.env
  repo_root = include.dev.locals.project_config.inputs.repo_root
}