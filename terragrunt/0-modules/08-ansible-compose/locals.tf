
locals {
  ansible_dir   = "${var.repo_root}/ansible/${var.env}"
  ansible_files = fileset(local.ansible_dir, "**")
}