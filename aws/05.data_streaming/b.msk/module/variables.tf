variable "phase" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "name_space" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "kafka_version" {
  type = string
  default = "2.8.1"
}

variable "broker_instance_type" {
  type = string
  description = "https://aws.amazon.com/msk/pricing/"
}

variable "broker_node_number" {
  type = number
  description = "The desired total number of broker nodes in the kafka cluster. It must be a multiple of the number of specified client subnets."
}

variable "broker_ebs_volume_gb_size" {
  type = number
  description = "The size in GiB of the EBS volume for the data drive on each broker node."
}

variable "client_subnets" {
  type = list(string)
  description = "A list of subnets to connect to in client VPC"
}

variable "default_sg_id" {
  description = "vpc default security group"
}