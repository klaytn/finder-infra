variable "random_id_enabled" {
  description = "Whether to enable random_id for bucket name."
  type    = bool
  default   = false
} 

variable "name" {
  description = "The name of the redis cluster."
  type    = string
}

variable "region" {
  description = "The region of the redis cluster."
  type    = string
  default   = "asia-northeast3"
}

variable "project" {
  description = "The project ID to manage the bucket."
  type    = string
}

variable "shard_count" {
  description = "The count of shard of the redis cluster."
  type    = string
}

variable "replica_count" {
  description = "The count of replication of the redis cluster."
  type    = string
}

variable "network_id" {
  description = "The id of network"
  type    = string
}

variable "subnetworks" {
  description = "The subnetwork that the redis cluster will use."
  type = list(string)
}

variable "zones" {
  description = "The availability zones"
  type = list(string)
}

variable "heap_size" {
  description = "The heap size of the elasticsearch node. (Recommend: 50% of the availabe system memory, under 32GB)"
  type = string
  default = "2g"
}

variable "cluster_name" {
  description = "The cluster name of the elasticsearch cluster."
  type = string
}

variable "masters_count" {
  description = "Number of dedicated master nodes in the cluster, used for setting minimum master nodes."
  type = number
  default = 0
}

variable "node_roles" {
  description = "The elasticsearch node's roles. if you want to additional information, pleast see this document: https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html#node-roles"
  type = list(string)
  default = [ "master", "data", "ingest" ]
}