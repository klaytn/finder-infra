terraform {
    backend "gcs" {
        bucket = "5afca53ca689347f-finder-tfstate"
        prefix = "terraform/tf-finder-kafka-prod"
    }
}