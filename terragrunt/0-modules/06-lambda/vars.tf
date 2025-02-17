
variable "repo_root" {
    description = "This project's directory root path"
    type        = string
}

variable "ec2_instance_name" {
    description = "Name of the EC2 instance"
    type        = string
}

variable "telegram_bot_token" {
  description = "Telegram Bot Token"
  type        = string
  sensitive   = true
}

variable "telegram_chat_id" {
  description = "Telegram Chat ID"
  type        = string
  sensitive   = true
}

variable "lambda_runtime" {
  description = "Lambda runtime"
  type        = string
}

variable "lambda_handler" {
  description = "Lambda handler"
  type        = string
}