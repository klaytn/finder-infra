variable "name" {}
variable "engine" {}
variable "engine_version" {}
variable "instance_class" {}
variable "instance_count" {}
variable "port" {}

variable "database_name" {}
variable "master_username" {}
variable "master_password" {}
variable "backup_retention_period" {}
variable "deletion_protection" {}
variable "skip_final_snapshot" {}

variable "pg_family" {}

variable "vpc_id" {}
variable "vpc_cidr" {}
variable "availability_zones" {}
variable "db_subnet_group_name" {}

variable "iam_roles" {}
variable "aws_default_s3_role" {}

