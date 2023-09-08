### create tfvars

```bash
cat <<EOL > terraform.tfvars
s3_bucket = "$ENV_S3_BUCKET"
s3_foundation_key = "terraform/$ENV/foundation"
aws_region = "$ENV_AWS_REGION"
aws_profile_name = "$ENV_AWS_PROFILE_NAME"
phase = "$ENV"
eks_name = ""
EOL
```

### installation

```bash
terraform init \
     -backend-config "bucket=$ENV_S3_BUCKET" \
     -backend-config "key=terraform/$ENV/eks" \
     -backend-config "region=$ENV_AWS_REGION" \
     -backend-config "profile=$ENV_AWS_PROFILE_NAME" \
     -backend-config "dynamodb_table=$ENV_DYNAMODB_TABLE" \
     -backend-config "encrypt=true"
```

```bash
terraform plan
```

```bash
terraform apply 
```

```bash
terraform destroy 
```