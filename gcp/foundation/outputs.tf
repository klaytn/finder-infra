output "vpc_finder_name" {
    value = module.network-finder-prod-vpc.network
}

output "vpc_finder_prod_subnets" {
    value = module.network-finder-prod-vpc.subnets
}

output "vpc_finder_prod_subnets_names" {
    value = module.network-finder-prod-vpc.subnets_names
}

output "vpc_finder_prod_subnets_self_links" {
    value = module.network-finder-prod-vpc.subnets_self_links
}

output "vpc_finder_prod_subnets_regions" {
    value = module.network-finder-prod-vpc.subnets_regions
}

output "vpc_finder_prod_subnets_secondary_ranges" {
    value = module.network-finder-prod-vpc.subnets_secondary_ranges
}

output "vpc_finder_prod_subnets_ips" {
    value = module.network-finder-prod-vpc.subnets_ips
}
