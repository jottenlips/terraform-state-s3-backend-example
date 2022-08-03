# Getting started with Terraform, using s3 state

1. comment out terraform state block to deploy bucket and dynamodb, deploy

```
terraform init
terraform plan
terraform apply
```

2. uncomment state, import dynamodb and s3_bucket that were created, deploy

```
terraform import aws_dynamodb_table.terraform_state_lock "tf-lock-table"
terraform import aws_s3_bucket.terraform_states "tf-states-s3backend"
terraform plan
terraform apply
```