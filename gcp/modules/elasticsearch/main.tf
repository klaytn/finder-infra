resource "random_id" "this" {
    byte_length = 8
}

locals {
  computed_name = var.random_id_enabled ? "${random_id.this.hex}-${var.name}" : var.name
  computed_cluster_name = var.random_id_enabled ? "${random_id.this.hex}-${var.name}-cluster" : "${var.name}-cluster"
  
  set_elasticsearch_script = templatefile("script/set-elasticsearch.sh", {
    project_id = var.project
    cluster_name = locals.computed_cluster_name
    zones = var.zones
    elasticsearch_data_dir = "/var/lib/elasticsearch"
    elasticsearch_logs_dir = "/var/log/elasticsearch"
    heap_size = var.heap_size
    node_roles = var.node_roles
    security_enabled = var.security_enabled
  })
}

resource "google_compute_instance_template" "default" {
  name         = "elasticsearch-template"
  machine_type = var.machine_type

  disk {
    source_image = data.google_compute_image.elasticsearch
    disk_size_gb = var.disk_size_gb
  }

  network_interface {
    network = data.google_compute_network.default.self_link
    subnetwork = data.google_compute_subnetwork.default.self_link

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
    ]
  }
}

# ToDo: 'node' module migrate to resource by provide google
resource "google_compute_region_instance_group_manager" "default" {
  name = "${locals.computed_name}-igm"
  base_instance_name = locals.computed_name
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