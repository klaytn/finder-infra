data "google_compute_image" "elasticsearch" {
  family = var.image_name
  project = var.project
}

data "google_compute_network" "default" {
  name = var.network
}

data "google_compute_subnetwork" "default" {
  name = var.subnetwork
}