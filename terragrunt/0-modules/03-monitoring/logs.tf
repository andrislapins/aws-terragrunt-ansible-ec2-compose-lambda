
### Cloudwatch log group and stream for following up the setup on the EC2 instance

resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/ec2/${var.ec2_instance_name}"
  retention_in_days = 1
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = "${var.ec2_instance_name}-log-stream"
  log_group_name = aws_cloudwatch_log_group.log_group.name
}
