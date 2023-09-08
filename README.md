# Finder Infrastructure

This repository is for the infrastructure of KlaytnFinder.
For the overall architecture of the finder, please refer to the [Main Repo](https://github.com/klaytn/finder/blob/main/README.md).

---

## Installation

Please refer to the /prod/README.md file in each folder for installation instructions.

1. Navigate to the folder of the step you want to execute.
2. Run `terraform init`. (Please read README.md in each folder)
3. Run `terraform plan`. Review the changes displayed in the console.
4. Run `terraform apply`. You'll need to input `yes`.
5. If an error occurs during `terraform apply`, execute `terraform destroy`.

[Terraform Official Documentation](https://developer.hashicorp.com/terraform/cli/commands)

## Operation

There are a total of 9 steps inside the aws folder. Each step is as follows:

When installing, please make sure to check if the variables exported in the 'init' step are retained, and if the terminal changes, re-export the variable values for use.

1.  **init**: Creates dynamodb and S3 buckets for managing Terraform state.
2.  **foundations**: Creates VPC, subnets, subnet groups, route tables, internet gateways, nat gateways, etc. Adjust CIDR, available zones, VPC name, etc., according to your environment.
3.  **redis**: Creates a Redis cluster.
4.  **rds**: Creates RDS. 
5.  **data_streaming**: Resources related to data processing.
    1. **s3**: Creates `lake`, `spark` buckets.
    2. **msk**: Creates a Kafka cluster.
    4. **emr**: Creates an EMR cluster. 
6. **opensearch**: Creates Opensearch Role and Domain.
7. **eks_cluster**: Creates EKS cluster and necessary `irsa`. 
8. **ecr**: Creates ECRs to be pulled by EKS PODs.
    - **finder-compiler-api**: Compiler-api image repository.
    - **finder-api**: Front-api, private-api image repository.
    - **finder-oapi**: Open-api image repository.
    - **finder-worker**: Worker image repository.
    - **finder-web**: Web image repository.    
9.  **en_node**: Executes scripts for installing EN Node after creating EC2 instances. Refer to [README.md](https://github.com/klaytn/finder-infra/blob/main/aws/05.en_node/README.md) at that location for guidance.
    - **private_archive_en_baobab**: Contains Baobab EN Node EC2 instance and kend.conf file.
    - **private_archive_en_cypress**: Contains Cypress EN Node EC2 instance and kend.conf file.