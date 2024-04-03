data "google_compute_image" "elasticsearch" {
  family = var.image_name
  project = var.project
}