### set gcloud
```bash
gcloud auth login
gcloud config set project <project name>
```

### Export environment variables
```bash
export TFSTATE_BUCKET_NAME=<gcp bucket name>
```

### create tfvars
```bash
`cat <<EOL > terraform.tfvars
name = ""
shard_count = 
replica_count = 
EOL`
```

### installation
```bash
terraform init \
-backend-config "bucket=$TFSTATE_BUCKET_NAME" 
```

```bash
terraform plan -var-file terraform.tfvars
```

```bash
terraform apply
```

### uninstallation
```bash
terraform destroy
```