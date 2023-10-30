variable "random_id_enabled" {
  description = "Whether to enable random_id for bucket name."
  type    = bool
  default   = false
} 

variable "name" {
  description = "The name of the elasticsearch cluster."
  type    = string
}

variable "region" {
  description = "The region of the elasticsearch cluster."
  type    = string
  default   = "asia-northeast3"
}

variable "project" {
  description = "The project ID to manage the bucket."
  type    = string
}

variable "network" {
  description = "The name of network."
  type    = string
}

variable "subnetwork" {
  description = "The subnetwork that the elasticsearch cluster will use."
  type = string
}

variable "zones" {
  description = "The availability zones"
  type = list(string)
}

variable "node_roles" {
  description = "The elasticsearch node's roles. if you want to additional information, pleast see this document: https://www.elastic.co/guide/en/elasticsearch/reference/current/modules-node.html#node-roles"
  type = list(string)
  default = [ "master", "data", "ingest" ]
}

variable "security_enabled" {
  description = "Which enables elasticsearch security features on node."
  type = bool
  default = false
}

variable "image_name" {
  description = "The name of the compute image for elasticsearch."
  type = string
  default = "elasticsearch-8"
}

variable "machine_type" {
  description = "The machine type of the elasticsearch node."
  type = string
}

variable "disk_size_gb" {
  description = "The disk size of node."
  type = number
}