
locals {
  cw_agent_config = templatefile("config/cw_agent_config.json", {
    log_group_name  = aws_cloudwatch_log_group.log_group.name
    log_stream_name = aws_cloudwatch_log_stream.log_stream.name
  })

  role_policy_arns = [
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]
}