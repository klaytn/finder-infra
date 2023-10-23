module "s3-data-lake_bucket" {
    source               = "../../modules/bucket"
    project              = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id 
    random_id_enabled    = var.random_id_enabled    
    name                 = var.s3_data_lake_bucket_name
    location             = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_regions[0]
    storage_class        = var.storage_class
    versioning_enabled   = var.versioning_enabled
}

module "s3-log-spark_bucket" {
    source               = "../../modules/bucket"
    project              = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id 
    random_id_enabled    = var.random_id_enabled    
    name                 = var.s3_log_spark_bucket_name
    location             = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_regions[0]
    storage_class        = var.storage_class
    versioning_enabled   = var.versioning_enabled
}

