
# IAM Role for EC2
resource "aws_iam_role" "ec2_instance_role" {
  name = "${var.ec2_instance_name}-ec2-instance-role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })
}

# Attach AmazonSSMManagedInstanceCore policy for SSM access
resource "aws_iam_role_policy_attachment" "ssm_core_policy_attachment" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Attach CloudWatch Logs full access
resource "aws_iam_role_policy_attachment" "cloudwatch_logs_policy_attachment" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

# Attach S3 full access policy
resource "aws_iam_role_policy_attachment" "s3_full_access_policy_attachment" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# IAM Instance Profile for EC2
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "${var.ec2_instance_name}-ec2-instance-profile"
  role = aws_iam_role.ec2_instance_role.name
}