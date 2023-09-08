variable "name" {}

variable "subnet_ids" {}
variable "public_subnet_ids" {}
variable "vpc_id" {}

variable "vpc_cidr" {}

variable "endpoint_public_access" {}

variable "nodegroup_default_instance_types" {}
variable "nodegroup_default_disk_size" {}
variable "nodegroup_default_scaling_config_desired_size" {}
variable "nodegroup_default_scaling_config_max_size" {}
variable "nodegroup_default_scaling_config_min_size" {}

variable "nodegroup_service_instance_types" {}
variable "nodegroup_service_disk_size" {}
variable "nodegroup_service_scaling_config_desired_size" {}
variable "nodegroup_service_scaling_config_max_size" {}
variable "nodegroup_service_scaling_config_min_size" {}

variable "nodegroup_infra_instance_types" {}
variable "nodegroup_infra_disk_size" {}
variable "nodegroup_infra_scaling_config_desired_size" {}
variable "nodegroup_infra_scaling_config_max_size" {}
variable "nodegroup_infra_scaling_config_min_size" {}