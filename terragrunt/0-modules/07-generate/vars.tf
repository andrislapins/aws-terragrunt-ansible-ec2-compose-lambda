
variable "env" {
    description = "Environment name"
    type        = string
}

variable "repo_root" {
    description = "This project's directory root path"
    type        = string
}

variable "traefik_admin_name" {
  description = "Traefik admin user name"
  type        = string
}

variable "traefik_admin_password" {
  description = "Traefik admin user password"
  type        = string
}