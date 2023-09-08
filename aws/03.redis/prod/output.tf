output "finder-redis" {
  value = module.finder-redis.redis
  sensitive = true
}