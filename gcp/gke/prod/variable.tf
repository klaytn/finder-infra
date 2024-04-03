variable "bucket" {
    type = string
    description = "terraform bucket name"
}

variable "cluster_name" {
  description = "The name of the cluster (required)"
  type        = string
  default     = "finder-prod"

}
