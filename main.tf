# Spin up neccessary resources for your terraform state

resource "aws_s3_bucket" "terraform_states" {
  bucket = "tf-states-s3backend"
  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }
  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "tf-lock-table"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

# terraform {
#   backend "s3" {
#     # Replace this with your bucket name!
#     bucket                  = "tf-states-s3backend"
#     key                     = "main.tf"
#     region                  = "us-east-1"
#     encrypt                 = true
#     profile                 = "default"
#     dynamodb_table          = "tf-lock-table"
#     shared_credentials_file = "$HOME/.aws/credentials"
#   }
# }
