output "redis_cluster_id" {
  value = google_redis_cluster.default.id
}

output "redis_cluster_name" {
    value = google_redis_cluster.default.name
}