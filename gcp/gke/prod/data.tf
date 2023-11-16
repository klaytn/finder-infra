data "terraform_remote_state" "foundation" {
    backend = "gcs"
    config = {
        bucket  = var.bucket
        prefix  = "terraform/tf-finder-foundation"
    }
}

data "terraform_remote_state" "secret" {
    backend = "gcs"
    config = {
        bucket  = var.bucket
        prefix  = "terraform/tf-finder-secret-prod"
    }
}

data "terraform_remote_state" "access" {
    backend = "gcs"
    config = {
        bucket  = var.bucket
        prefix  = "terraform/tf-finder-access-prod"
    }
}

data "terraform_remote_state" "sa" {
    backend = "gcs"
    config = {
        bucket  = var.bucket
        prefix  = "terraform/tf-finder-sa-prod"
    }
}
