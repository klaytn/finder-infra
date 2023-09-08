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

  variable "engine_version" {
    description = "Redis engine version"
    type        = string
    default     = "6.x"
  }

  variable "name" {
    description = "Name of the Redis cluster"
    type        = string
  }

  variable "node_type" {
    description = "Redis node type"
    type        = string
    default     = "cache.r6g.large"
  }

  variable "num_node_groups" {
    description = "Number of node groups"
    type        = number
    default     = 10
  }

  variable "replicas_per_node_group" {
    description = "Number of replicas per node group"
    type        = number
    default     = 1
  }

  variable "port" {
    description = "Redis port"
    type        = number
  }