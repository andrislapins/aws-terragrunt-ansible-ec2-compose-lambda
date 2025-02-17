
terraform {
  source = "../../0-modules/05-instance"
}

include "dev" {
  path   = find_in_parent_folders("dev.hcl")
  expose = true
}

inputs = {
  region                 = include.dev.locals.project_config.inputs.region
  project                = include.dev.locals.project_config.inputs.project
  env                    = include.dev.locals.env
  repo_root              = include.dev.locals.project_config.inputs.repo_root
  ec2_instance_name      = "${include.dev.locals.project_config.inputs.project}-${include.dev.locals.env}-ec2"
  ec2_instance_disk_size = 25
  ec2_instance_type      = "t3.medium"
}

dependency "network" {
  config_path = "../01-network"

  mock_outputs = {
    vpc_id             = "mock-vpc-id-1234"
    vpc_public_subnets = ["mock-subnet-1234", "mock-subnet-5678"]
  }
}

dependency "instance_role" {
  config_path = "../02-instance-role"

  mock_outputs = {
    ec2_instance_role_id   = "terragrunt-mock-ec2_instance_role_id"
    ec2_instance_role_name = "terragrunt-mock-ec2_instance_role_name"
  }
}