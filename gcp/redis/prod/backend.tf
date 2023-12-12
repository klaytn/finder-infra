terraform {
    backend "gcs" {
        prefix = "terraform/tf-finder-redis-prod"
    }
}