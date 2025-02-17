
### For setting up the altering of successful/failed docker-compose deployment
### on the EC2 instance

# To be able to send messages from EC2 to SNS
resource "aws_iam_role_policy" "ec2_sns_policy" {
  name = "${var.ec2_instance_name}-sns-policy"
  role = data.aws_iam_role.ec2_instance_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sns:Publish",
          "sns:ListTopics"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_sns_topic" "ansible_notification" {
  name = "${var.ec2_instance_name}-ansible-playbook-notifications"
}

# Create a Lambda execution role
resource "aws_iam_role" "lambda_role" {
  name = "${var.ec2_instance_name}-lambda-sns-execution-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach the policies needed for Lambda to work with SNS and CloudWatch Logs
resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_role.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Action   = "sns:Publish",
        Effect   = "Allow",
        Resource = aws_sns_topic.ansible_notification.arn
      }
    ]
  })
}

# FIXME: Read that some "Lambda layers" could be a solution for packaging functions
# TODO: To this automatic packaging of Lambda functions within /lambda directory
# resource "null_resource" "package_lambda" {
#   provisioner "local-exec" {
#     command = <<EOT
#       # Install dependencies
#       pip install requests -t ./lambda

#       # Remove unnecessary directories
#       rm -rf ./lambda/bin/

#       # Package the Lambda function and dependencies into a ZIP file
#       zip -r ./lambda/telegram_notif.py.zip \
#           lambda/requests/ \
#           lambda/requests-2.32.3.dist-info/ \
#           lambda/certifi/ \
#           lambda/certifi-2024.8.30.dist-info/ \
#           lambda/idna/ \
#           lambda/idna-3.8.dist-info/ \
#           lambda/charset_normalizer/ \
#           lambda/charset_normalizer-3.3.2.dist-info/ \
#           lambda/urllib3/ \
#           lambda/urllib3-2.2.2.dist-info/ \
#           lambda/telegram_notif.py
#     EOT
#   }
#   triggers = {
#     always_run = "${timestamp()}"
#   }
# }

# FIXME: Why does Lambda message to my bot comes more than once?
# Upload Lambda function code (Make sure to package your Python code into a ZIP file)
resource "aws_lambda_function" "telegram_notifier" {
  function_name = "${var.ec2_instance_name}-telegram-notifier"
  role          = aws_iam_role.lambda_role.arn
  runtime       = var.lambda_runtime
  handler       = var.lambda_handler

  filename = "${var.repo_root}/lambda/telegram_notif.py.zip"

  environment {
    variables = {
      TOKEN   = var.telegram_bot_token
      CHAT_ID = var.telegram_chat_id
    }
  }

  # depends_on = [
  #   null_resource.package_lambda
  # ]
}

# Set the Lambda trigger to be SNS
resource "aws_lambda_permission" "allow_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.telegram_notifier.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.ansible_notification.arn
}

# Link the SNS topic to the Lambda function
resource "aws_sns_topic_subscription" "telegram_notifications" {
  topic_arn = aws_sns_topic.ansible_notification.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.telegram_notifier.arn
}