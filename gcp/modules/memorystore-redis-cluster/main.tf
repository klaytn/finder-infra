resource "random_id" "this" {
    byte_length = 8
}

resource "google_redis_cluster" "default" {
  project        = var.project
  name           = var.random_id_enabled ? "${random_id.this.hex}-${var.name}" : var.name
  shard_count    = var.shard_count
  replica_count  = var.replica_count
  psc_configs {
    network = var.network
  }
  region = var.region
  
  transit_encryption_mode = "TRANSIT_ENCRYPTION_MODE_DISABLED"
  authorization_mode = "AUTH_MODE_DISABLED"
  depends_on = [
    google_network_connectivity_service_connection_policy.default
  ]
}

resource "google_network_connectivity_service_connection_policy" "default" {
  project        = var.project
  name           = var.random_id_enabled ? "${random_id.this.hex}-${var.name}-connection-policy" : "${var.name}-connection-policy"
  location       = var.region
  service_class  = "gcp-memorystore-redis"
  description    = "service connection policy for redis cluster"
  network        = var.network
  psc_config {
    subnetworks = var.subnetworks
  }
}