terraform {
    backend "gcs" {
        prefix = "terraform/tf-finder-kafka-prod"
    }
}