output "gke_node_service_account_id" {
    description = "The service account ID"
    value       = module.gke_node_service_account.account_id
}

output "gke_node_service_account_email" {
    description = "The service account email"
    value       = module.gke_node_service_account.email
}

output "finder_service_account_id" {
    description = "The service account id"
    value       = module.finder_service.account_id
}

output "finder_service_account_email" {
    description = "The service account email"
    value       = module.finder_service.email
}