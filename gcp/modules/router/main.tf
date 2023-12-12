resource "google_compute_router" "default" {
    project = var.project
    name    = var.name
    network = var.network
    region  = var.region
}