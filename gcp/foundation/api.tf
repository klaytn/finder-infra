module "enabled_google_apis" {
    source  = "terraform-google-modules/project-factory/google//modules/project_services"
    version = "~> 14.0"

    project_id                  = var.project_id
    disable_services_on_destroy = false

    activate_apis = [
        "compute.googleapis.com",
        "cloudapis.googleapis.com",
        "vpcaccess.googleapis.com",
        "servicenetworking.googleapis.com",
        "iap.googleapis.com",
        "oslogin.googleapis.com",
        "cloudkms.googleapis.com",
        "container.googleapis.com",
        "secretmanager.googleapis.com",
        "redis.googleapis.com",
        "networkconnectivity.googleapis.com",
        "serviceconsumermanagement.googleapis.com",
        "dataproc.googleapis.com"
    ]
}