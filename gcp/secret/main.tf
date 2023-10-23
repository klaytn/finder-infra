module "secret-manager" {
    source  = "GoogleCloudPlatform/secret-manager/google"
    version = "~> 0.1"
    project_id = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    secrets = [
        {
        name                     = var.secret_name
        automatic_replication    = true
        secret_data              = var.secret_data
        },
    ]
}