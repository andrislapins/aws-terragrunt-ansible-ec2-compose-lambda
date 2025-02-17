
terraform {
  source = "../../0-modules/07-generate"
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
  traefik_admin_name     = include.dev.locals.project_config.inputs.traefik_admin_name
  traefik_admin_password = include.dev.locals.project_config.inputs.traefik_admin_password
}