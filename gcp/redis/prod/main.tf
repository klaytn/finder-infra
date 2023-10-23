module "memorystore-redis-cluster" {
  project   = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
  source    = "../../modules/memorystore-redis-cluster"
  name      = "redis"
  region    = "asia-northeast3"
  shard_count = 20
  network_id = data.terraform_remote_state.foundation.outputs.vpc_finder_name.network_id
  replica_count = 1
  subnetworks = [
    data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets["asia-northeast3/sb-finder-prod-shared"].id
  ]
}