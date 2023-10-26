module "en-cypress" {
    source           = "../../../modules/en_node/cypress"
    zone             = "${data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_regions[0]}-b" 
    project          = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    subnetwork       = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_self_links[0]
}
