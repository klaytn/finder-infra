module "openvpn" {
    source           = "../../modules/openvpn" 
    name             = var.ovpn_name
    region           = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_regions[0]
    zone             = "${data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_regions[0]}-a" 
    project_id       = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    host_project_id  = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
    network          = data.terraform_remote_state.foundation.outputs.vpc_finder_name.network_name
    subnetwork       = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_self_links[var.ovpn_subnet_number]
    output_dir       = "./openvpn"
    users            = var.users
}
