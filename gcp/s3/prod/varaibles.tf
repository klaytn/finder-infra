variable "bucket" {
    type = string
    description = "terraform bucket name"
}

variable "s3_data_lake_bucket_name" {
    type = string
    description = "The name of the bucket"
    default = null
}

variable "s3_log_spark_bucket_name" {
    type = string
    description = "The name of the bucket"
    default = null
}

variable "random_id_enabled" {
    type = bool
    description = "Whether to enable random id"
    default = true
}

variable "storage_class" {
    type = string
    description = "The storage class of the bucket"
    default = "STANDARD"
}

variable "versioning_enabled" {
    type = bool
    description = "Whether to enable versioning"
    default = true
}