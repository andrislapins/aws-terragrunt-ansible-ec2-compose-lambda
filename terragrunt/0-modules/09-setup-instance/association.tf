
resource "aws_ssm_association" "run_setup_script_association" {
  name             = aws_ssm_document.run_setup_script.name
  instance_id      = aws_instance.web.id
  association_name = "run-setup-script"

  parameters = {
    account_id            = var.aws_account_id
    region                = var.region
    bucket_name           = var.ansible_bucket_name
    ssm_cloudwatch_config = var.cw_agent_config_name
  }
}