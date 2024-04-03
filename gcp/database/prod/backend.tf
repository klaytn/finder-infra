terraform {
    backend "gcs" {
        prefix = "terraform/tf-finder-database-prod"
    }
}