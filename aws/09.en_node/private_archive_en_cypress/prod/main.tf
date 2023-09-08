data "terraform_remote_state" "foundation" {
  backend = "s3"
  config = {
    bucket = var.s3_bucket
    key    = var.s3_foundation_key
    region = var.aws_region
    profile = var.aws_profile_name
  }
}

module "klaytn_prod-private-archive-en-cypress" {
  source               = "../module"
  name                 = var.name
  ec2_ids              = [var.name]
  phase                = var.phase
  instance_type        = "m5.2xlarge"
  root_volume_size_gib = 16384
  vpc_id               = data.terraform_remote_state.foundation.outputs.vpc_info.vpc_id
  vpc_subnet_ids       = data.terraform_remote_state.foundation.outputs.private_en_subnet_info.id
}
