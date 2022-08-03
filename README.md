# Getting started with Terraform, using s3 state

## Chicken or Egg?

In order to use terraform to keep track of your infrastructure, you need a terraform backend. A terraform backend on AWS requires a dynamodb table and an s3 bucket. You could spin up these resources in the console or the aws cli, but what if you want these resources under terraform as well? These 3 steps will get your terraform state under terraform.

1. comment out the terraform backend to deploy bucket and dynamodb, deploy

```
terraform init
terraform plan
terraform apply
```

2. uncomment terraform backend, import dynamodb and s3_bucket that were created, deploy

```
terraform import aws_dynamodb_table.terraform_state_lock "tf-lock-table"
terraform import aws_s3_bucket.terraform_states "tf-states-s3backend"
terraform plan
terraform apply
```

You now have a terraform backend on s3!

3. Use terraform state in other repos for you aws account

```
terraform {
  backend "s3" {
    bucket                  = "tf-states-s3backend"
    key                     = "environments/develop/network.tf"
    region                  = "us-east-1"
    encrypt                 = true
    profile                 = "default"
    dynamodb_table          = "tf-lock-table"
    shared_credentials_file = "$HOME/.aws/credentials"
  }
}
```
