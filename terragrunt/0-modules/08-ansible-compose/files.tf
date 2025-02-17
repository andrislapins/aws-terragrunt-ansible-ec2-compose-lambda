
resource "aws_s3_object" "ansible_files" {
  for_each = local.ansible_files
  bucket   = var.ansible_bucket_name
  key      = "ansible/${each.value}"
  source   = "${local.ansible_dir}/${each.value}"
  acl      = "private"
}