
terraform {
  source = "../../0-modules/06-lambda"
}

include "dev" {
  path   = find_in_parent_folders("dev.hcl")
  expose = true
}

inputs = {
  region             = include.dev.locals.project_config.inputs.region
  project            = include.dev.locals.project_config.inputs.project
  env                = include.dev.locals.env
  repo_root          = include.dev.locals.project_config.inputs.repo_root
  ec2_instance_name  = "${include.dev.locals.project_config.inputs.project}-${include.dev.locals.env}-ec2"
  telegram_bot_token = include.dev.locals.project_config.inputs.telegram_bot_token
  telegram_chat_id   = include.dev.locals.project_config.inputs.telegram_chat_id
  lambda_runtime     = "python3.10"
  lambda_handler     = "telegram_notif.lambda_handler"
}

dependency "instance_role" {
  config_path = "../02-instance-role"

  mock_outputs = {
    ec2_instance_role_id   = "terragrunt-mock-ec2_instance_role_id"
    ec2_instance_role_name = "terragrunt-mock-ec2_instance_role_name"
  }
}