
terraform {
  source = "../../0-modules/05-instance"
}

include "prod" {
  path   = find_in_parent_folders("prod.hcl")
  expose = true
}

inputs = {
  region                 = include.prod.locals.project_config.inputs.region
  project                = include.prod.locals.project_config.inputs.project
  env                    = include.prod.locals.env
  repo_root              = include.prod.locals.project_config.inputs.repo_root
  ec2_instance_name      = "${include.prod.locals.project_config.inputs.project}-${include.prod.locals.env}-ec2"
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