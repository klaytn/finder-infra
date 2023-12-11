terraform {
    backend "gcs" {
        prefix = "terraform/tf-finder-elasticsearch-prod-v2"
    }
}