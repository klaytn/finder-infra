terraform {
    backend "gcs" {
        prefix = "terraform/tf-finder-sa-prod"
    }
}