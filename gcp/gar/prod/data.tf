data "terraform_remote_state" "foundation" {
    backend = "gcs"
    config = {
        prefix  = "terraform/tf-finder-foundation"
    }
}