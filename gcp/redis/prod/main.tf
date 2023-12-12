locals {
  region = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_regions[0]
}

module "memorystore-redis-cluster" {
  project   = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
  source    = "../../modules/memorystore-redis-cluster"
  region    = local.region
  network_id = data.terraform_remote_state.foundation.outputs.vpc_finder_name.network_id
  subnetworks = [
    data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets["asia-northeast3/sb-finder-prod-shared"].id
  ]

  name      = var.name
  shard_count = var.shard_count
  replica_count = var.replica_count
}