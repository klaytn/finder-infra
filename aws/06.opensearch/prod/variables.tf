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

variable "domain_name" {
    type = string
}

variable "phase" {
    type = string
}

variable "instance_type" {
    type = string
    default = "m5.2xlarge.search"
}

variable "instance_count" {
    type = number
    default = 2
}

variable "node_ebs_volume_gib" {
    type = number
    default = 1536
}

variable "namespace" {
    type = string
}