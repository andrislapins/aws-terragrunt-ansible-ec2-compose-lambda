
resource "aws_security_group" "host_security_group" {
  name        = local.security_group_name
  description = "Security group for HTTP, HTTPS, and SSH access"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [format("%s/%s", data.external.whatismyip.result["internet_ip"], 32)]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name       = local.security_group_name
    managed_by = "Terraform"
    env        = var.env
    project    = var.project
  }
}