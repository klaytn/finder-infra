variable "random_id_enabled" {
    description = "Whether to enable random_id for bucket name."
    type        = bool
    default     = false
} 

variable "name" {
    description = "The name of the bucket."
    type        = string
}

variable "location" {
    description = "The location of the bucket."
    type        = string
    default     = "ap-southeast-1"
}

variable "storage_class" {
    description = "The storage class of the bucket."
    type        = string
    default     = "STANDARD"
}

variable "versioning_enabled" {
    description = "Whether to enable versioning."
    type        = bool
    default     = true
}

variable "project" {
    description = "The project ID to manage the bucket."
    type        = string
    default     = "tfstate-bucket"
}