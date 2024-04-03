variable "random_id_enabled" {
    description = "Whether to enable random_id for bucket name."
    type        = bool
    default     = false
} 

variable "name" {
    description = "The name of the redis cluster."
    type        = string
}

variable "region" {
    description = "The region of the redis cluster."
    type        = string
    default     = "asia-northeast3"
}

variable "project" {
    description = "The project ID to manage the bucket."
    type        = string
}

variable "shard_count" {
    description = "The count of shard of the redis cluster."
    type        = string
}

variable "replica_count" {
    description = "The count of replication of the redis cluster."
    type        = string
}

variable "network_id" {
    description = "The id of network"
    type        = string
}

variable "subnetworks" {
    description = "The subnetwork that the redis cluster will use."
    type = list(string)
}
