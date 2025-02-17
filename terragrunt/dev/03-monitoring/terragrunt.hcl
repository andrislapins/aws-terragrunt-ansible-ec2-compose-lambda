
terraform {
  source = "../../0-modules/03-monitoring"
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

dependency "instance_role" {
  config_path = "../02-instance-role"

  mock_outputs = {
    ec2_instance_role_id   = "terragrunt-mock-ec2_instance_role_id"
    ec2_instance_role_name = "terragrunt-mock-ec2_instance_role_name"
  }
}