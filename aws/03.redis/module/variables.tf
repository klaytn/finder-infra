variable "vpc_id" {
    description = "VPC ID"
    type        = string
}

variable "vpc_cidr" {
    description = "VPC CIDR"
    type        = string
}

variable "elasticache_subnet_group_name" {
    description = "Elasticache subnet group name"
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