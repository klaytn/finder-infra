resource "random_id" "this" {
    byte_length = 8
}

locals {
  computed_name = var.random_id_enabled ? "${random_id.this.hex}-${var.name}" : var.name
  computed_cluster_name = var.random_id_enabled ? "${random_id.this.hex}-${var.cluster_name}" : var.cluster_name
  
  set_elasticsearch_script = templatefile("script/set-elasticsearch.sh", {
    project_id = var.project
    cluster_name = locals.computed_cluster_name
    zones = var.zones
    elasticsearch_data_dir = "/var/lib/elasticsearch"
    elasticsearch_logs_dir = "/var/log/elasticsearch"
    heap_size = var.heap_size
    minimum_master_nodes = "${format("%d", var.masters_count / 2 + 1)}"
    node_roles = var.node_roles
    security_enabled = var.security_enabled
    monitoring_enabled = var.monitoring_enabled
  })
}

data "google_compute_image" "elasticsearch" {
  family = "elasticsearch-8"
  project = var.project
}

resource "google_redis_cluster" "default" {
  project        = var.project
  name           = locals.computed_name
  shard_count    = var.shard_count
  replica_count  = var.replica_count
  psc_configs {
    network = var.network_id
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
  network        = var.network_id
  psc_config {
    subnetworks = var.subnetworks
  }
}


# =============
# =============
# =============




resource "google_compute_region_instance_group_manager" "default" {
  name = "${var.name}-group"
  base_instance_name = var.name
  region = var.region
  distribution_policy_zones = var.zones

  version {
    instance_template = 
  }
}

module "node" {
  source                    = "GoogleCloudPlatform/managed-instance-group/google"
  version                   = "1.1.15"
  project                   = var.project
  region                    = var.region
  zonal                     = false
  distribution_policy_zones = ["${var.zones}"]
  network                   = "${var.network}"
  subnetwork                = "${var.subnetwork}"
  network_ip                = "${var.network_ip}"
  access_config             = ["${var.access_config}"]
  target_tags               = ["${compact(concat(list("${var.name}", "${var.cluster_name}"), var.node_tags))}"]
  machine_type              = "${var.machine_type}"
  name                      = "${var.name}"
  compute_image             = "${data.google_compute_image.elasticsearch.self_link}"
  disk_auto_delete          = "${var.disk_auto_delete}"
  disk_type                 = "${var.disk_type}"
  disk_size_gb              = "${var.disk_size_gb}"
  size                      = "${var.num_nodes}"
  service_port              = "9200"
  service_port_name         = "http"
  wait_for_instances        = true
  update_strategy           = "NONE"
  http_health_check         = false
}

data "google_compute_region_instance_group" "default" {
  self_link = "${module.node.region_instance_group}"
}