variable "project" {
  description = "The ID of the project in which the resources will be deployed."
  type        = string
}

variable "region" {
  description = "The region of the elasticsearch cluster."
  type        = string
  default     = "asia-northeast3"
}

variable "subnetwork" {
  description = "The name or self_link of the subnetwork where this instance will be created."
  type        = string
}

variable "master_machine_type" {
  description = "The master node machine type to create."
  type        = string
}

variable "worker_machine_type" {
  description = "The worker node machine type to create."
  type        = string
}

variable "preemptible_worker_machine_type" {
  description = "The preemptible worker node machine type to create."
  type        = string
}

variable "boot_disk_size_gb" {
  description = "The size of the boot disk in GB attached to the instance."
  type        = number
  default     = 128
}

variable "master_num_instances" {
  description = "The number of master nodes in the cluster."
  type        = number
  default     = 1
}

variable "worker_num_instances" {
  description = "The number of worker nodes in the cluster."
  type        = number
  default     = 10
}

variable "preemptible_worker_num_instances" {
  description = "The number of preemptible worker nodes in the cluster."
  type        = number
  default     = 0
}

variable "name" {
  description = "The name of the cluster."
  type        = string
}

variable "tags" {
  description = "The network tags attached to the cluster."
  type        = list(string)
  default     = []
}

variable "image_version" {
  description = "The version of the dataproc image to use."
  type        = string
  default     = "2.0.82-debian10"
}