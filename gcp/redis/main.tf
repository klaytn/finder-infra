module "memorystore-redis-cluster" {
  project   = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
  source    = "../modules/memorystore-redis-cluster"
  name      = "redis"
  shard_count = 20
  network   = data.terraform_remote_state.foundation.outputs.vpc_finder_name.network_name
  region    = "asia-northeast3"
  replica_count = 1
  subnetworks = [
    "sb-finder-prod-shared"
  ]
}