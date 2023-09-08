data "terraform_remote_state" "foundation" {
  backend = "s3"
  config = {
    bucket = var.s3_bucket
    key    = var.s3_foundation_key
    region = var.aws_region
    profile = var.aws_profile_name
  }
}

data "aws_security_groups" "selected" {
  filter {
    name   = "group-name"
    values = ["default"]
  }

  filter {
    name   = "vpc-id"
    values = [data.terraform_remote_state.foundation.outputs.vpc_info.vpc_id]
  }
}

module "msk" {
  source    = "../module"
  cluster_name = var.cluster_name
  phase     = var.phase
  vpc_id = data.terraform_remote_state.foundation.outputs.vpc_info.vpc_id
  broker_instance_type = var.broker_instance_type
  broker_node_number = var.broker_node_number
  broker_ebs_volume_gb_size = var.broker_ebs_volume_gb_size
  client_subnets = data.terraform_remote_state.foundation.outputs.public_subnet_info.id
  default_sg_id = data.aws_security_groups.selected.ids[0]
  name_space = var.name_space
}
