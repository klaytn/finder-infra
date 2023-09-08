### Initial backend setting

```bash
export ENV_S3_BUCKET=${aws bucket name} \
export ENV=${envirement} \
export ENV_AWS_REGION=${aws region} \
export ENV_AWS_PROFILE_NAME=${aws profile} \
export ENV_DYNAMODB_TABLE=${aws dynamodb name}
```

### Example

```bash
    export ENV_S3_BUCKET=your_bucket_name \
    export ENV=prod \
    export ENV_AWS_REGION=your_aws_region \
    export ENV_AWS_PROFILE_NAME=your_aws_profile \
    export ENV_DYNAMODB_TABLE=your_dynamodb_table_name
```

### create terraform.tfvars

```bash
cat <<EOL > terraform.tfvars
s3_bucket = "$ENV_S3_BUCKET"
environment = "$ENV"
aws_region = "$ENV_AWS_REGION"
aws_profile_name = "$ENV_AWS_PROFILE_NAME"
dynamodb_table = "$ENV_DYNAMODB_TABLE"
EOL
```

```bash
terraform init
```

```bash
terraform plan
```

```bash
terraform apply
```
