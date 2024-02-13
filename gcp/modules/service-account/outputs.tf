output "account_id" {
    description = "The service account ID."
    value       = google_service_account.default.id
}

output "id" {
    description = "The service account ID."
    value       = google_service_account.default.unique_id
}

output "display_name" {
    description = "The service account display name."
    value       = google_service_account.default.display_name
}

output "email" {
    description = "The service account email."
    value       = google_service_account.default.email
}

output "name" {
    description = "The service account name."
    value       = google_service_account.default.name
}