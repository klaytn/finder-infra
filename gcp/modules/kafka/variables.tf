variable "servers" {
    type = number
}

variable "subnetwork" {
  description = "The name of the subnetwork to attach this interface to. The subnetwork must exist in the same region this instance will be created in. Either network or subnetwork must be provided."
  default     = null
  type        = string
}

variable "zone" {
    type = string
}

variable "zookeeper_up" {
    type = bool
}

variable "project" {
    type = string
}