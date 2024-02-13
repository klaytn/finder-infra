terraform {
    backend "gcs" {
        prefix = "terraform/tf-finder-foundation"
    }
}