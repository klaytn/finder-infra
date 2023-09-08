### create tfvars

```bash
cat <<EOL > terraform.tfvars
s3_bucket = "$ENV_S3_BUCKET"
s3_foundation_key = "terraform/$ENV/foundation"
aws_region = "$ENV_AWS_REGION"
aws_profile_name = "$ENV_AWS_PROFILE_NAME"
engine_version = 
name = 
node_type = 
num_node_groups = 
replicas_per_node_group = 
port =
EOL
```

### example (default)

```bash
engine_version = "6.x"
name = "${redis cluster name}"
node_type = "cache.r6g.large"
num_node_groups = 10
replicas_per_node_group = 1
port = "${redis port you want}"
```

### edit terraform.tfvars for redis specs


### installation

```bash
terraform init \
     -backend-config "bucket=$ENV_S3_BUCKET" \
     -backend-config "key=terraform/$ENV/redis" \
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