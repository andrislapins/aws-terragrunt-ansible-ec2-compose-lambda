
output "backend_bucket_name" {
  value = module.backend.state_bucket_name
}

output "backend_dynamodb_table_name" {
  value = module.backend.dynamodb_table_name
}