### create tfvars

```bash
cat <<EOL > terraform.tfvars
s3_bucket = "$ENV_S3_BUCKET"
s3_foundation_key = "terraform/$ENV/foundation"
aws_region = "$ENV_AWS_REGION"
aws_profile_name = "$ENV_AWS_PROFILE_NAME"
rds_name = ""
instance_class = "db.r5.large"
database_name = ""
cidr = ""
master_username = 
master_password = 
availability_zones = ["", ""]
port = 
EOL
```

### example 

```bash
rds_role_name = "defaultRDS2S3"
rds_name = "testrds"
instance_class = "db.r5.large"
database_name = "testdb"
master_username = "test-user"
master_password = "test-password"
cidr = "10.1.0.0/16"
availability_zones = ["ap-northeast-2a", "ap-northeast-2b"]
port = 3306
```

### edit terraform.tfvars for rds specs


### installation

```bash
terraform init \
     -backend-config "bucket=$ENV_S3_BUCKET" \
     -backend-config "key=terraform/$ENV/rds" \
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