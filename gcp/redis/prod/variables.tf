variable "name" {
  description = "The name of redis cluster."
  type = string
}

variable "shard_count" {
  description = "The number of shards."
  type = number
}

variable "replica_count" {
  description = "The number of replicas."
  type = number
}

variable "bucket" {
    type = string
    description = "terraform bucket name"
}