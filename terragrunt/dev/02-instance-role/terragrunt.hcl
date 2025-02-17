
terraform {
  source = "../../0-modules/02-instance-role"
}

include "dev" {
  path   = find_in_parent_folders("dev.hcl")
  expose = true
}

inputs = {
  region            = include.dev.locals.project_config.inputs.region
  project           = include.dev.locals.project_config.inputs.project
  env               = include.dev.locals.env
  ec2_instance_name = "${include.dev.locals.project_config.inputs.project}-${include.dev.locals.env}-ec2"
}