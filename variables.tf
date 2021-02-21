variable "aws_profile" {
  type        = string
  description = "AWS Profile used for pre environment"
}

variable "tags" {
  type        = map(any)
  description = "The map of common tags for resources"
  default = {
    "Created-by" = "aws-state-bucket"
    "Management" = "terraform-training"
  }
}

variable "remote_state_bucket_name" {
  type        = string
  description = "The name for the S3 state bucket"
}

variable "dynamo_state_table_name" {
  type        = string
  description = "The name for the DynamoDB state table"
}

variable "aws_region" {
  type        = string
  description = "The AWS region to deploy state bucket and table into"
}
