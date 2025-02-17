
data "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.ec2_instance_name}-ec2-instance-profile"
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["${var.env}-${var.project}-vpc"]
  }
}

data "aws_subnets" "vpc_public_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:network_tier"
    values = ["public"]
  }
}

data "aws_ssm_parameter" "latest_ubuntu_24_server" {
  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

data "external" "whatismyip" {
  program = ["/bin/bash", "./scripts/get-my-public-ip.sh"]
}