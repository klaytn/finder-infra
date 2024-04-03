### set gcloud
```bash
gcloud auth login
gcloud config set project <project name>
```

### Export environment variables
```bash
export TFSTATE_BUCKET_NAME=<gcp bucket name>
```

### (Once) build ElasticSearch image
If you first deploy elasticsearch by using this module, you need build image by packer.

Generate JSON service account key
```bash
PROJECT=$(gcloud config get-value project)
PROJECT_NUM=$(gcloud projects describe ${PROJECT} --format='value(projectNumber)')
SA_EMAIL="${PROJECT_NUM}-compute@developer.gserviceaccount.com"

gcloud iam service-accounts keys create .gcp_account.json --iam-account=${SA_EMAIL}
```

After that, build by packer
```bash
# Build elasticsearch 8
packer build -only=googlecompute -var-file=variables.json -var gcp_project_id=$(gcloud config get-value project) elasticsearch8-node.packer.json

# Build elasticsearch 7
packer build -only=googlecompute -var-file=variables.json -var gcp_project_id=$(gcloud config get-value project) elasticsearch7-node.packer.json
```

### create tfvars
```bash
`cat <<EOL > terraform.tfvars
name = ""
machine_type = ""
disk_size_gb =
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