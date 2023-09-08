
variable "domain_name" {
  type = string
}

variable "phase" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_count" {
  type = number
}

variable "node_ebs_volume_gib" {
  type = number
}

variable "node_ebs_volume_type" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "namespace" {
  type = string
}

