
data "aws_iam_role" "ec2_instance_role" {
  name = "${var.ec2_instance_name}-ec2-instance-role"
}