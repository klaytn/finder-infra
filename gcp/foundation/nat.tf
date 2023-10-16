module "router_finder" {
    source  = "../modules/router"
    project = var.project_id
    name    = "nat-${var.project_name}-router-prod"
    network = module.network-finder-prod-vpc.network_name
    region  = var.region
}


module "cloud-nat-vpc-prod" {
    source                             = "terraform-google-modules/cloud-nat/google"
    version                            = "~> 1.2"
    project_id                         = var.project_id
    region                             = var.region
    router                             = module.router_finder.name
    name                               = "nat-config"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}