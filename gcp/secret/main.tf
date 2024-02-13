/* module "secret-manager" {
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
} */

module "secret-kms" {
    source          = "terraform-google-modules/kms/google"
    version         = "~> 2.2.1"
    project_id      = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    location        = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_regions[0]
    keyring         = var.kms_keyring
    keys            = var.kms_keys
    prevent_destroy = false
}