variable "name" {
    description = "The name of the elasticsearch node."
    type        = string
}

variable "machine_type" {
  description = "The machine type of node."
  type = string
}

variable "disk_size_gb" {
  description = "The disk size of the elasticsearch node."
  type = number
}