
terraform {
  source = "../../0-modules/02-instance-role"
}

include "prod" {
  path   = find_in_parent_folders("prod.hcl")
  expose = true
}

inputs = {
  region            = include.prod.locals.project_config.inputs.region
  project           = include.prod.locals.project_config.inputs.project
  env               = include.prod.locals.env
  ec2_instance_name = "${include.prod.locals.project_config.inputs.project}-${include.prod.locals.env}-ec2"
}