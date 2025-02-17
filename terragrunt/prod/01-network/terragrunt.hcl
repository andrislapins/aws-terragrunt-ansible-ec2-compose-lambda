
terraform {
  source = "../../0-modules/01-network"
}

include "prod" {
  path   = find_in_parent_folders("prod.hcl")
  expose = true
}

inputs = {
  region         = include.prod.locals.project_config.inputs.region
  project        = include.prod.locals.project_config.inputs.project
  env            = include.prod.locals.env
  vpc_cidr_block = "10.10.20.0/24"
}