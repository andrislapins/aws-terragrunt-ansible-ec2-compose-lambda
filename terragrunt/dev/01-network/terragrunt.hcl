
terraform {
  source = "../../0-modules/01-network"
}

include "dev" {
  path   = find_in_parent_folders("dev.hcl")
  expose = true
}

inputs = {
  region         = include.dev.locals.project_config.inputs.region
  project        = include.dev.locals.project_config.inputs.project
  env            = include.dev.locals.env
  vpc_cidr_block = "10.10.10.0/24"
}