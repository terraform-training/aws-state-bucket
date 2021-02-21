output "kms_id" {
  value       = aws_kms_key.s3_state_key.id
  description = "Global KMS key identifier"
}

output "kms_arn" {
  value       = aws_kms_key.s3_state_key.arn
  description = "The ARN to created the S3 state KMS key"
}

output "state_bucket_name" {
  value       = aws_s3_bucket.terraform_state_bucket.bucket
  description = "The name of created the state s3 bucket"
}

output "dynamodb_lock_table" {
  value       = aws_dynamodb_table.terraform_state_lock.name
  description = "Name of the created lock table dynamodb"
}

output "init_command" {
  value       = format("terraform init -backend-config=\"bucket=%s\" -backend-config=\"key=<ENV>/terraform.tfstate\" -backend-config=\"encrypt=true\" -backend-config=\"profile=%s\" -backend-config=\"dynamodb_table=%s\" -backend-config=\"kms_key_id=%s\" -backend-config=\"region=%s\"", aws_s3_bucket.terraform_state_bucket.bucket, var.aws_profile, aws_dynamodb_table.terraform_state_lock.name, aws_kms_key.s3_state_key.id, var.aws_region)
  description = "terraform init command example"
}
