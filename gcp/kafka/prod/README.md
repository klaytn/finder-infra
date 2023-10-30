# Kafka and Zookeeper Instance Deployment

## Prerequisites
Ensure that the Google Cloud SDK and Terraform are installed on your machine.

## Getting Started
### 1. **Login to Google Cloud**
```bash
gcloud auth login
```
### 2. Create Kafka and Zookeeper Images with Packer 
Navigate to the Packer directory and build the images.
```bash
cd packer/
packer build kafka-image.json
packer build zookeeper-image.json
```

### 3. Initialize Terraform 
```bash
terraform init -backend-config "bucket=$TFSTATE_BUCKET_NAME" 
```
### 4. Generate and Review the Execution
Plan In this step, Terraform will generate an execution plan describing what it will do to reach the desired state.
```bash
terraform plan
```
### 5. Build the Resources 
Apply your configuration to reach the desired state of your infrastructure.
```bash
terraform apply
```

# Destroying the Infrastructure
To destroy all resources created by your Terraform script, run the following command.
```bash
terraform destroy
```