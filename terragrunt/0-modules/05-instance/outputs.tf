
output "ec2_instance_id" {
  description = "Underlying host instance ID"
  value       = aws_instance.host.id
}

output "ec2_instance_private_key_path" {
  description = "Path to the private key file for SSH access"
  value       = local.ec2_instance_private_key_path
}

output "my_public_ip" {
  value       = data.external.whatismyip.result["internet_ip"]
  description = "The public IP address of the current machine"
}