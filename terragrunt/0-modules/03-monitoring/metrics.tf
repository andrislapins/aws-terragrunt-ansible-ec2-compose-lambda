
### For configuring the EC2 instance to send broader metrics

resource "aws_ssm_parameter" "cw_agent" {
  name        = "/${var.ec2_instance_name}/cloudwatch-agent/config"
  description = "Cloudwatch agent config to configure custom logs and metrics"
  type        = "String"
  value       = local.cw_agent_config
}

resource "aws_iam_role_policy_attachment" "cw_agent_policy_attachment_aws" {
  count      = length(local.role_policy_arns)

  role       = data.aws_iam_role.ec2_instance_role.name
  policy_arn = element(local.role_policy_arns, count.index)
}

resource "aws_iam_role_policy" "cw_agent_policy_attachment_custom_ssm_cw_config" {
  name = "EC2-Allow-Read-CW-Config-On-SSM-Parameters"
  role = data.aws_iam_role.ec2_instance_role.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "ssm:GetParameter"
          ],
          "Resource" : aws_ssm_parameter.cw_agent.arn
        }
      ]
    }
  )
}