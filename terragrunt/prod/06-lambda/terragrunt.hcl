
terraform {
  source = "../../0-modules/06-lambda"
}

include "prod" {
  path   = find_in_parent_folders("prod.hcl")
  expose = true
}

inputs = {
  region             = include.prod.locals.project_config.inputs.region
  project            = include.prod.locals.project_config.inputs.project
  env                = include.prod.locals.env
  repo_root          = include.prod.locals.project_config.inputs.repo_root
  ec2_instance_name  = "${include.prod.locals.project_config.inputs.project}-${include.prod.locals.env}-ec2"
  telegram_bot_token = include.prod.locals.project_config.inputs.telegram_bot_token
  telegram_chat_id   = include.prod.locals.project_config.inputs.telegram_chat_id
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