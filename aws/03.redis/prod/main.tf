data "terraform_remote_state" "foundation" {
  backend = "s3"
  config = {
    bucket = var.s3_bucket
    key    = var.s3_foundation_key
    region = var.aws_region
    profile = var.aws_profile_name
  }
}

module "finder-redis" {
  source = "../module"
  elasticache_subnet_group_name = data.terraform_remote_state.foundation.outputs.aws_elasticache_subnet_group.name
  vpc_cidr                      = data.terraform_remote_state.foundation.outputs.vpc_info.cidr_block
  vpc_id                        = data.terraform_remote_state.foundation.outputs.vpc_info.vpc_id
  engine_version                = var.engine_version
  name                          = var.name
  node_type                     = var.node_type
  num_node_groups               = var.num_node_groups
  replicas_per_node_group       = var.replicas_per_node_group
  port                          = var.port
}

