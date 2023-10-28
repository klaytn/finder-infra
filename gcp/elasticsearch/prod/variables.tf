variable "name" {
    description = "The name of the elasticsearch node."
    type        = string
}

variable "region" {
    description = "The region of the elasticsearch node."
    type        = string
    default     = "asia-northeast3"
}

variable "project" {
    description = "The project ID."
    type        = string
}

variable "machine_type" {
  description = "The machine type of node."
  type = string
}

variable "heap_size" {
  description = "The heap size of the elasticsearch node. (Recommend: 50% of the availabe system memory, under 32GB)"
  type = string
  default = "2g"
}

variable "disk_size_gb" {
  description = "The disk size of the elasticsearch node."
  type = string
  default = "50"
}