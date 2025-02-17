
data "external" "htpasswd_hash" {
  program = ["bash", "./scripts/generate_htpasswd.sh", var.traefik_admin_name, var.traefik_admin_password]
}

resource "local_file" "docker_compose" {
  content  = templatefile("${var.repo_root}/ansible/docker-compose.tpl.yml", {
    traefik_admin = data.external.htpasswd_hash.result["output"]
  })
  filename = "${var.repo_root}/ansible/${var.env}/docker-compose.yml"
}

output "htpasswd_creds" {
  description = "The generated password hash from the external script"
  value       = data.external.htpasswd_hash.result["output"]
}