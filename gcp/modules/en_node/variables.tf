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

variable "name" {
  description = "The name of the instance."
  type        = string
}

variable "machine_type" {
  description = "The machine type to create."
  type        = string
}

variable "tags" {
  description = "A list of tags to apply to the resources."
  type        = list(string)
}

variable "disk_size_gb" {
    description = "The size of the boot disk in GB."
    type        = number
}