locals {
  modules = {
    "finder-base"            = "Module for finder-base",
    "finder-api"             = "Module for finder-api",
    "finder-compiler-api"    = "Module for finder-compiler-api",
    "finder-oapi"            = "Module for finder-oapi",
    "finder-worker"          = "Module for finder-worker",
    "finder-web"             = "Module for finder-web",
    "finder-web-nginx"       = "Module for finder-web-nginx",
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