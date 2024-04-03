resource "random_id" "this" {
    byte_length = 8
}

resource "google_storage_bucket" "default" {
    project       = var.project
    name          = var.random_id_enabled ? "${random_id.this.hex}-${var.name}" : var.name
    force_destroy = false
    location      = var.location
    storage_class = var.storage_class
    versioning {
        enabled = var.versioning_enabled
    }
}