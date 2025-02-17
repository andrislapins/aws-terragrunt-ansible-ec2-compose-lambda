

resource "tls_private_key" "ec2_instance_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_instance_keypair" {
  key_name   = local.ec2_instance_keypair_name
  public_key = tls_private_key.ec2_instance_key.public_key_openssh
}

resource "local_file" "ec2_instance_private_key" {
  content         = tls_private_key.ec2_instance_key.private_key_pem
  filename        = local.ec2_instance_private_key_path
  file_permission = "0600"
}

# just make the filename into single local var and then output that var