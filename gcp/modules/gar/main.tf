resource "google_artifact_registry_repository" "registry" {
  provider      = google-beta
  project       = var.project
  location      = var.location
  repository_id = var.repository_id
  description   = var.description
  format        = "DOCKER"

  docker_config {
    immutable_tags = true
  }
}

resource "google_artifact_registry_repository_iam_binding" "bindings" {
  project    = google_artifact_registry_repository.registry.project
  location   = google_artifact_registry_repository.registry.location
  repository = google_artifact_registry_repository.registry.name

  role       = "roles/artifactregistry.admin"
  members    = ["allAuthenticatedUsers"]
}

resource "google_artifact_registry_repository_iam_binding" "reader_binding" {
  project    = google_artifact_registry_repository.registry.project
  location   = google_artifact_registry_repository.registry.location
  repository = google_artifact_registry_repository.registry.name

  role       = "roles/artifactregistry.reader"
  members    = ["allUsers"]
}

resource "google_artifact_registry_repository_iam_binding" "writer_binding" {
  project    = google_artifact_registry_repository.registry.project
  location   = google_artifact_registry_repository.registry.location
  repository = google_artifact_registry_repository.registry.name

  role       = "roles/artifactregistry.writer"
  members    = ["allAuthenticatedUsers"]
}
