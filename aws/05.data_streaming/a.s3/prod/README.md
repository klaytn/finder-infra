### create tfvars

```bash
cat <<EOL > terraform.tfvars
aws_region = "$ENV_AWS_REGION"
aws_profile_name = "$ENV_AWS_PROFILE_NAME"
s3_burket_lake_id = "your data lake storing s3 name"
s3_burket_spark_id = "your spark related data storing s3 name"
phase = "$ENV"
EOL
```
### edit terraform.tfvars for your s3 name


### installation

```bash
terraform init \
     -backend-config "bucket=$ENV_S3_BUCKET" \
     -backend-config "key=terraform/$ENV/s3" \
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
terraform destroy -var "aws_region=${ENV_AWS_REGION}" -var "aws_profile_name=${ENV_AWS_PROFILE_NAME}"
```