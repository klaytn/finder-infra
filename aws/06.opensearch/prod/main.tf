data "terraform_remote_state" "foundation" {
  backend = "s3"
  config = {
    bucket = var.s3_bucket
    key    = var.s3_foundation_key
    region = var.aws_region
    profile = var.aws_profile_name
  }
}

module "finder-opensearch-domain" {
  source               = "../module/domain"
  domain_name          = var.domain_name
  namespace            = var.namespace
  phase                = var.phase
  engine_version       = "OpenSearch_1.2"
  instance_type        = var.instance_type
  instance_count       = var.instance_count
  subnet_ids           = data.terraform_remote_state.foundation.outputs.private_db_subnet_info.id
  node_ebs_volume_gib  = var.node_ebs_volume_gib                                                                                 # 1.6 TB
  node_ebs_volume_type = "gp2"
  vpc_id               = data.terraform_remote_state.foundation.outputs.vpc_info.vpc_id
}
