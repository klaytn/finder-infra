output "elasticsearch_cluster_name" {
  value = google_compute_region_instance_group_manager.default.name
}