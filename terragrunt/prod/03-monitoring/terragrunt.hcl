
terraform {
  source = "../../0-modules/03-monitoring"
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

dependency "instance_role" {
  config_path = "../02-instance-role"

  mock_outputs = {
    ec2_instance_role_id   = "terragrunt-mock-ec2_instance_role_id"
    ec2_instance_role_name = "terragrunt-mock-ec2_instance_role_name"
  }
}