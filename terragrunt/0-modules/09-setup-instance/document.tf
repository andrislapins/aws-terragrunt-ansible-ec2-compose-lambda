
resource "aws_ssm_document" "run_setup_script" {
  name          = "${var.ec2_instance_name}-run-setup-script"
  document_type = "Command"

  content = jsonencode({
    schemaVersion = "2.2"
    description   = "Run setup script on EC2"
    mainSteps = [
      {
        action = "aws:runShellScript"
        name   = "runShellScript"
        inputs = {
          runCommand = [
            "echo 'Running setup script'",
            "sudo apt-get update",
            "sudo apt-get upgrade -y",
            "sudo apt-get install -y curl",
            
            # Download CloudWatch Agent
            "curl https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb -o amazon-cloudwatch-agent.deb",
            "sudo dpkg -i amazon-cloudwatch-agent.deb",

            # CloudWatch Agent setup
            "sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c ssm:${ssm_cloudwatch_config} -s",
            "sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a status",

            # Setup Ansible and AWS CLI
            "sudo apt-get install -y python3-pip ansible unzip",
            "curl \"https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip\" -o \"awscliv2.zip\"",
            "unzip awscliv2.zip",
            "sudo ./aws/install",
            "aws --version",

            # Download Ansible playbook from S3
            "aws s3 sync s3://${bucket_name}/ansible/ /home/ubuntu/",

            # Run the playbook
            "cd /home/ubuntu",
            "ansible-playbook setup_docker.yml",

            # Send result of playbook
            "if [ $? -eq 0 ]; then",
            "  echo \"Ansible playbook completed successfully\"",
            "  aws sns publish --topic-arn arn:aws:sns:${region}:${account_id}:ansible-playbook-notifications --message \"Playbook completed successfully.\"",
            "else",
            "  echo \"Ansible playbook failed\"",
            "  aws sns publish --topic-arn arn:aws:sns:${region}:${account_id}:ansible-playbook-notifications --message \"Playbook failed.\"",
            "fi"
          ]
        }
      }
    ]
  })
}