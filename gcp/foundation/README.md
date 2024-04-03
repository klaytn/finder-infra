### gcloud login
```bash
gcloud auth login
```

### create tfvars
```bash
`cat <<EOL > terraform.tfvars
project_id      = "$PROJECT_ID"
project_name    = "$PROJECT_NAME"
region          = "$YOUR_REGION"
EOL`

```

### installation

```bash
terraform init \
-backend-config "bucket=$TFSTATE_BUCKET_NAME" 
```

```bash
terraform plan
```

```bash
terraform apply 
```

### uninstallation

```bash
terraform destroy 
````