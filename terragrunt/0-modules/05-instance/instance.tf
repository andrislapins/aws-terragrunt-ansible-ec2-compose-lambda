
resource "aws_instance" "host" {
  instance_type = var.ec2_instance_type
  ami           = data.aws_ssm_parameter.latest_ubuntu_24_server.value

  key_name      = aws_key_pair.ec2_instance_keypair.key_name

  vpc_security_group_ids = [aws_security_group.host_security_group.id]
  subnet_id              = data.aws_subnets.vpc_public_subnets.ids[0]

  iam_instance_profile = data.aws_iam_instance_profile.ec2_instance_profile.name

  root_block_device {
    volume_size = var.ec2_instance_disk_size
  }

  tags = {
    Name       = var.ec2_instance_name
    managed_by = "Terraform"
    env        = var.env
    project    = var.project
  }
}