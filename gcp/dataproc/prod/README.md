# Google Cloud Dataproc Terraform Configuration

## Overview
This project automates the configuration and deployment of a big data processing cluster using Google Cloud's Dataproc service through Terraform. Using Terraform for infrastructure management enables consistent and efficient handling of resources, as it turns infrastructure into code.

## Prerequisites
* A Google Cloud account is required.
* Google Cloud SDK must be installed.


## Configuration
The main.tf file includes the Terraform configuration to create a Dataproc cluster. It defines resources such as:

* Google Cloud Dataproc cluster

## Usage
1. Set up your Google Cloud project.
2. Run gcloud auth application-default login to configure your credentials.
3. Configure necessary variables in the variables.tf file.
4. Initialize Terraform by
running ``terraform init`` in your terminal.
5. Execute ``terraform plan`` to review the execution plan.

Deploy your infrastructure with ``terraform apply``.

## Cleanup
To remove the resources when they are no longer needed, use the ``terraform destroy`` command.

