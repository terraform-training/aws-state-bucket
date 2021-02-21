resource "aws_kms_key" "s3_state_key" {
  description             = "This key is used to encrypt state bucket"
  deletion_window_in_days = 10
  tags                    = var.tags
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = var.dynamo_state_table_name
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  server_side_encryption {
    enabled = true
  }

  tags = var.tags
}

resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = var.remote_state_bucket_name
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.s3_state_key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }

  tags = var.tags
}

resource "local_file" "init" {
  content  = format("terraform init -backend-config=\"bucket=%s\" -backend-config=\"key=<ENV>/terraform.tfstate\" -backend-config=\"encrypt=true\" -backend-config=\"profile=%s\" -backend-config=\"dynamodb_table=%s\" -backend-config=\"kms_key_id=%s\" -backend-config=\"region=%s\"", aws_s3_bucket.terraform_state_bucket.bucket, var.aws_profile, aws_dynamodb_table.terraform_state_lock.name, aws_kms_key.s3_state_key.id, var.aws_region)
  filename = "init.sh"
}
