variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "default"
}

variable "aws_profile_name" {
    description = "AWS profile name"
    type        = string
}

variable "s3_bucket" {
    description = "S3 bucket name"
    type        = string
}

variable "s3_foundation_key" {
    description = "s3 bucket key for foundation state file"
    type        = string
}

variable name_space {
    type = string
    default = "test"
}

variable phase {
    type = string
    default = "prod"
}

variable cluster_name {
    type = string
    default = "test-prod-kafka"
}

variable broker_instance_type {
    type = string
    default = "kafka.m5.xlarge"
}

variable "broker_node_number" {
    type = number
    default = 3
}

variable "broker_ebs_volume_gb_size" {
    type = number
    default = 100
}