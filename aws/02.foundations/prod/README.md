### set up terraform.tfvars

+ example
```bash
aws_region = 
aws_profile_name = 
vpc = {
    vpc_name = "finder_test_vpc",
    cidr_block = "10.2.0.0/16",
}

availability_zones = ["ap-northeast-2a", "ap-northeast-2b"]

vpc_endpoint_service = "com.amazonaws.ap-northeast-2.s3"
vpc_endpoint_name = "finder-test-vpce-s3"
phase = "prod"
```


### installation

```bash
terraform init \
     -backend-config "bucket=$ENV_S3_BUCKET" \
     -backend-config "key=terraform/$ENV/foundation" \
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