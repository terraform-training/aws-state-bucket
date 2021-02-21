# aws-state-bucket

Example project that creates S3 backend for Terraform state.

Components and capabilities:

* S3 bucket (versioning)
* DynamoDB table (locking)
* KMS key (encryption)

## Usage

Modify default.auto.tfvars or provide the variables by CLI. Run once and use the command to set up backend in another project.

Remember, you need to add to another project the partial configuration definition:

```tf
terraform {
  backend "s3" {}
}
```
