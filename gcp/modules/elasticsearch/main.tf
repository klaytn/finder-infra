resource "random_id" "this" {
    byte_length = 8
}

locals {
  computed_name = var.random_id_enabled ? "${random_id.this.hex}-${var.name}" : var.name
  computed_cluster_name = var.random_id_enabled ? "${random_id.this.hex}-${var.name}-cluster" : "${var.name}-cluster"
  
  set_elasticsearch_script = templatefile("${path.module}/script/set-elasticsearch.sh", {
    project_id = var.project
    cluster_name = local.computed_cluster_name
    zones = jsonencode(var.zones)
    elasticsearch_data_dir = "/var/lib/elasticsearch"
    elasticsearch_logs_dir = "/var/log/elasticsearch"
    node_roles = jsonencode(var.node_roles)
    security_enabled = var.security_enabled
  })
}

resource "google_compute_instance_template" "default" {
  project = var.project
  name         = "elasticsearch-template"
  machine_type = var.machine_type

  disk {
    source_image = data.google_compute_image.elasticsearch.name
    disk_size_gb = var.disk_size_gb
  }

  network_interface {
    network = var.network
    subnetwork = var.subnetwork

    # secret default
    access_config {
      network_tier = "PREMIUM"
    }
  }

  # secret default
  service_account {
    scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/pubsub",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/compute",
    ]
  }

  metadata = {
    startup-script = local.set_elasticsearch_script
  }
}

# ToDo: 'node' module migrate to resource by provide google
resource "google_compute_region_instance_group_manager" "default" {
  project = var.project
  name = "${local.computed_name}-igm"
  base_instance_name = local.computed_name
  region = var.region
  distribution_policy_zones = var.zones
  target_size = 2

  version {
    instance_template = google_compute_instance_template.default.self_link_unique
  }

  named_port {
    name = "elasticsearch-http"
    port = 9200
  }
}