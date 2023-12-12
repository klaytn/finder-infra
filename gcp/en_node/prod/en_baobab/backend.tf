terraform {
    backend "gcs" {
        prefix = "terraform/tf-finder-en-baobab-prod"
    }
}