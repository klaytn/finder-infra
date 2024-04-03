locals {
  modules = {
    "finder-prod"            = "Module for finder"
  }
}

module "gar" {
  source        = "../../modules/gar"
  project       = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
  location      = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_regions[0]
  
  for_each      = local.modules

  repository_id = each.key
  description   = each.value
}