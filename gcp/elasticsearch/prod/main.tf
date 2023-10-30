locals {
  region = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_regions[0]
}

module "elasticsearch" {
  source = "../../modules/elasticsearch"

  project = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
  region = local.region
  zones = ["${local.region}-a", "${local.region}-b"]
  network = data.terraform_remote_state.foundation.outputs.vpc_finder_name.network.self_link
  subnetwork = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets["asia-northeast3/sb-finder-prod-shared"].id
  
  name = var.name
  machine_type = var.machine_type
  disk_size_gb = var.disk_size_gb
}