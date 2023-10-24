data "terraform_remote_state" "foundation" {
    backend = "gcs"
    config = {
        bucket  = "5afca53ca689347f-finder-tfstate"
        prefix  = "terraform/tf-finder-foundation"
    }
}

data "terraform_remote_state" "secret" {
    backend = "gcs"
    config = {
        bucket  = "5afca53ca689347f-finder-tfstate"
        prefix  = "terraform/tf-finder-secret-prod"
    }
}