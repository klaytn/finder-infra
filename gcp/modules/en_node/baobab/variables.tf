variable "project" {
  description = "The ID of the project in which the resources will be deployed."
  type        = string
}

variable "zone" {
  description = "The zone in which the compute instance should exist."
  type        = string
}

variable "subnetwork" {
  description = "The name or self_link of the subnetwork where this instance will be created."
  type        = string
}
