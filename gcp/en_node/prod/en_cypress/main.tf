module "en-cypress" {
    source           = "../../../modules/en_node"
    name             = "finder-en-cypress-prod"
    machine_type     = "e2-standard-8"
    tags             = ["ssh", "finder-en-node"]
    zone             = "${data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_regions[0]}-b" 
    project          = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    subnetwork       = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_self_links[0]
    disk_size_gb     = 12288
}