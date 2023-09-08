### create tfvars

```bash
cat <<EOL > terraform.tfvars
aws_region = "$ENV_AWS_REGION"
aws_profile_name = "$ENV_AWS_PROFILE_NAME"
phase = "$ENV"
EOL
```

### installation

```bash
terraform init \
     -backend-config "bucket=$ENV_S3_BUCKET" \
     -backend-config "key=terraform/$ENV/ecr" \
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