## gke node pool service account

module "gke_node_service_account" {
    source           = "../../modules/service-account"
    project          = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    account_id       = "sa-finder-prod-gke-node"
    display_name     = "finder-prod-gke-node-service-account"
    description      = "GKE Node Service Account"
}

# gke node service account 
# https://cloud.google.com/kubernetes-engine/docs/how-to/hardening-your-cluster?hl=ko


module "project_logging_log_writer_iam_policy_binding" {
    source             = "../../modules/project-iam-binding"
    project            = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    role               = "roles/logging.logWriter"
    members            = ["serviceAccount:${module.gke_node_service_account.email}"]
}

module "project_monitoring_metric_writer_iam_policy_binding" {
    source             = "../../modules/project-iam-binding"
    project            = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    role               = "roles/monitoring.metricWriter"
    members            = ["serviceAccount:${module.gke_node_service_account.email}"]
}

module "project_monitoring_viewer_iam_policy_binding" {
    source             = "../../modules/project-iam-binding"
    project            = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    role               = "roles/monitoring.viewer"
    members            = ["serviceAccount:${module.gke_node_service_account.email}"]
}

module "project_stackdriver_resource_metadata_writer_iam_policy_binding" {
    source             = "../../modules/project-iam-binding"
    project            = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    role               = "roles/stackdriver.resourceMetadata.writer"
    members            = ["serviceAccount:${module.gke_node_service_account.email}"]
}

module "project_autoscaling_metrics_writer_iam_policy_binding" {
    source             = "../../modules/project-iam-binding"
    project            = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    role               = "roles/autoscaling.metricsWriter"
    members            = ["serviceAccount:${module.gke_node_service_account.email}"]
}

module "project_storage_object_viewer_iam_policy_binding" {
    source             = "../../modules/project-iam-binding"
    project            = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    role               = "roles/storage.objectViewer"
    members            = ["serviceAccount:${module.gke_node_service_account.email}"]
}

module "project_iam_service_account_user_iam_policy_binding" {
    source             = "../../modules/project-iam-binding"
    project            = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    role               = "roles/iam.serviceAccountUser"
    members            = ["serviceAccount:${module.gke_node_service_account.email}"]
}


module "finder_service" {
    source           = "../../modules/service-account"
    project          = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    account_id       = "sa-prod-finder-service"
    display_name     = "finder-prod-service-account-99"
    description      = "GKE Finder Pod Service Account"
}


module "project_cloudsql_client_iam_policy_binding" {
    source             = "../../modules/project-iam-binding"
    project            = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    role               = "roles/cloudsql.client"
    members            = ["serviceAccount:${module.gke_node_service_account.email}" , "serviceAccount:${module.finder_service.email}"]
}

module "project_cloudkms_crypto_key_encrypter_decrypter_iam_policy_binding" {
    source             = "../../modules/project-iam-binding"
    project            = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    role               = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
    members            = ["serviceAccount:${module.gke_node_service_account.email}" , "serviceAccount:${module.finder_service.email}"]
}

module "project_object_viewer_iam_policy_binding" {
    source             = "../../modules/project-iam-binding"
    project            = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    role               = "roles/storage.objectViewer"
    members            = ["serviceAccount:${module.gke_node_service_account.email}" , "serviceAccount:${module.finder_service.email}"]
}

module "project_artifactregistry_reader_iam_policy_binding" {
    source             = "../../modules/project-iam-binding"
    project            = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    role               = "roles/artifactregistry.reader"
    members            = ["serviceAccount:${module.gke_node_service_account.email}" , "serviceAccount:${module.finder_service.email}"]
}

/* module "project_kms_crypto_key_iam_binding" {
    source             = "../../modules/kms-crypto-key-iam-binding"
    key_ring_id        = data.terraform_remote_state.secret.outputs.keyring_resource.id
    crypto_key_id      = data.terraform_remote_state.secret.outputs.keys.gke-etcd-keys-prod-00
    members            = ["serviceAccount:${module.gke_node_service_account.email}" , "serviceAccount:${module.finder_service.email}" ]
} */
