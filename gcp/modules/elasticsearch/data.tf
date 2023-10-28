resource "random_id" "this" {
    byte_length = 8
}

locals {
  computed_name = var.random_id_enabled ? "${random_id.this.hex}-${var.name}" : var.name
  computed_cluster_name = var.random_id_enabled ? "${random_id.this.hex}-${var.cluster_name}" : var.cluster_name
}

data "google_compute_image" "elasticsearch" {
  family = "elasticsearch-8"
  project = var.project
}