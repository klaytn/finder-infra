module "private-service-access" {
  source               = "GoogleCloudPlatform/sql-db/google//modules/private_service_access"
  address              = "10.178.2.0"
  prefix_length        = 24 
  project_id           = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
  vpc_network          = data.terraform_remote_state.foundation.outputs.vpc_finder_name.network_name
}

module "finder-baobab" {
  source               = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  name                 = "finder-baobab"
  random_instance_name = false
  database_version     = "MYSQL_8_0"
  project_id           = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
  zone                 = var.zone
  region               = var.region
  root_password        = var.password
  tier                 = "db-n1-highmem-8"
  enable_default_user  = true
  
  deletion_protection  = false
  ip_configuration     = {
    ipv4_enabled         = false
    private_network      = data.terraform_remote_state.foundation.outputs.vpc_finder_name.network_self_link
    require_ssl          = false
    allocated_ip_range   = module.private-service-access.google_compute_global_address_name
    authorized_networks  = var.authorized_networks
  }

  password_validation_policy_config = {
    # Complexity Default - password must contain at least one lowercase, one uppercase, one number and one non-alphanumeric characters.
    complexity                  = "COMPLEXITY_DEFAULT"
    disallow_username_substring = true
    min_length                  = 8
    # Password change interval format is in seconds. 3600s=1h
    password_change_interval = "0s"
    reuse_interval           = 1
    enable_password_policy   = true
  }

  enable_random_password_special = true

  iam_users = var.iam_users
  module_depends_on    = [module.private-service-access.peering_completed]
}

module "finder-cypress" {
  source               = "GoogleCloudPlatform/sql-db/google//modules/mysql"
  name                 = "finder-cypress"
  random_instance_name = false
  database_version     = "MYSQL_8_0"
  project_id           = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
  zone                 = var.zone
  region               = var.region
  root_password        = var.password
  tier                 = "db-n1-highmem-32"
  enable_default_user  = true
  
  deletion_protection  = false
  ip_configuration     = {
    ipv4_enabled         = false
    private_network      = data.terraform_remote_state.foundation.outputs.vpc_finder_name.network_self_link
    require_ssl          = false
    allocated_ip_range   = module.private-service-access.google_compute_global_address_name
    authorized_networks  = var.authorized_networks
  }

  password_validation_policy_config = {
    # Complexity Default - password must contain at least one lowercase, one uppercase, one number and one non-alphanumeric characters.
    complexity                  = "COMPLEXITY_DEFAULT"
    disallow_username_substring = true
    min_length                  = 8
    # Password change interval format is in seconds. 3600s=1h
    password_change_interval = "0s"
    reuse_interval           = 1
    enable_password_policy   = true
  }

  enable_random_password_special = true

  iam_users = var.iam_users
  module_depends_on    = [module.private-service-access.peering_completed]
}
