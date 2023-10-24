resource "google_service_account_iam_binding" "default" {
    service_account_id = var.service_name
    role               = var.role
    members            = var.members
}