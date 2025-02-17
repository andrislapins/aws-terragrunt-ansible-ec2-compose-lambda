
output "ec2_instance_role_id" {
    value = aws_iam_role.ec2_instance_role.id
}

output "ec2_instance_role_name" {
    value = aws_iam_role.ec2_instance_role.name
}
