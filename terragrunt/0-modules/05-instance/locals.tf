
locals {
    ec2_instance_keypair_name     = "${var.ec2_instance_name}-keypair"
    security_group_name           = "${var.ec2_instance_name}-security-group"
    ec2_instance_private_key_path = "${var.repo_root}/keys/${local.ec2_instance_keypair_name}.pem"
}