### gcloud login
```bash
gcloud auth login
```

### create tfvars
```bash
`cat <<EOL > terraform.tfvars
ovpn_name          = "finder-prod-ovpn"
ovpn_subnet_number = 1
users              = ["anyuser"]
bucket             = "$TFSTATE_BUCKET_NAME"
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