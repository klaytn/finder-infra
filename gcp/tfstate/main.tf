module "tfstate_bucket" {
    source               = "../modules/bucket"
    project              = var.project    
    random_id_enabled    = var.random_id_enabled    
    name                 = var.name
    location             = var.location
    storage_class        = var.storage_class
    versioning_enabled   = var.versioning_enabled
}