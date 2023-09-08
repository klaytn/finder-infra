data "terraform_remote_state" "foundation" {
  backend = "s3"
  config = {
    bucket = var.s3_bucket
    key    = var.s3_foundation_key
    region = var.aws_region
    profile = var.aws_profile_name
  }
}

module "rds_role" {
  source = "../modules/rds_role"
  name = var.rds_role_name
}

module "finder_rds_cluster" {
  source = "../modules/rds_cluster"

  name           = var.rds_name
  engine         = "aurora-mysql"
  engine_version = "8.0.mysql_aurora.3.01.0"
  instance_class = var.instance_class 
  instance_count = 1
  port           = var.port

  database_name           = var.database_name
  master_username         = var.master_username
  master_password         = var.master_password
  backup_retention_period = 1
  deletion_protection     = true
  skip_final_snapshot     = true

  pg_family = "aurora-mysql8.0"

  vpc_id               = data.terraform_remote_state.foundation.outputs.vpc_info.vpc_id
  vpc_cidr             = var.cidr
  availability_zones   = var.availability_zones
  db_subnet_group_name = data.terraform_remote_state.foundation.outputs.aws_db_subnet_group.name

  iam_roles           = [module.rds_role.rds_role_arn]
  aws_default_s3_role = module.rds_role.rds_role_arn

  depends_on = [ module.rds_role ]
}
