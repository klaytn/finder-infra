module "kafka" {
  source            = "../../modules/kafka"
  project           = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
  zone              = "${data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_regions[0]}-a"
  subnetwork        = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_self_links[0]
  servers           = 3
  zookeeper_up      = module.zookeeper.cluster_up
}

module "zookeeper" {
  source            = "../../modules/zookeeper"
  project           = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
  zone              = "${data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_regions[0]}-a"
  subnetwork        = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_self_links[0]
  servers           = 3
}