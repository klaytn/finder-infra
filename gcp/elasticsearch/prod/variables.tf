variable "bucket" {
    type = string
    description = "terraform bucket name"
}

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

variable "image_name" {
  description = "The elasticsearch version."
  type = string
  default = "elasticsearch-8"
}