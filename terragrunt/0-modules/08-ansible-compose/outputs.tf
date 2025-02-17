
output "local_ansible_dir" {
  description = "Path to the Ansible directory"
  value       = local.ansible_dir
}

output "local_ansible_files" {
  description = "List of Ansible files in the directory"
  value       = local.ansible_files
}