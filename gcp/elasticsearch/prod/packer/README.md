# Elasticsearch and Kibana machine images

This Packer configuration will generate Ubuntu images with Elasticsearch and other important tools for deploying and managing Elasticsearch clusters on the GCP.

The output of running Packer here would be a machine image, as below:

* elasticsearch node image, containing latest Elasticsearch installed (latest version 8.x) and configured with best-practices.

## How to build
First, you need this command before generate JSON SA key.
```
gcloud config set proejct <project name>
```

Generate the JSON SA(service account) key for the default compute engine service account:
```
PROJECT=$(gcloud config get-value project)
PROJECT_NUM=$(gcloud projects describe ${PROJECT} --format='value(projectNumber)')
SA_EMAIL="${PROJECT_NUM}-compute@developer.gserviceaccount.com"

gcloud iam service-accounts keys create .gcp_account.json --iam-account=${SA_EMAIL}
```

Building:
```
packer build -only=googlecompute -var-file=variables.json -var gcp_project_id=$(gcloud config get-value project) elasticsearch8-node.packer.json
```