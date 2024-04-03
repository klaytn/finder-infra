variable "database_password" {
  type = string
  description = "The password for the default database user"
  default = null
}

variable "bucket" {
  type = string
  description = "Terraform state bucket"
}

variable "iam_users" {
  description = "A list of IAM users to be created in your CloudSQL instance"
  type = list(object({
    id    = string,
    email = string
  }))
  default = []
}

variable "authorized_networks" {
  type        = list(map(string))
  description = "List of mapped public networks authorized to access to the instances. Default - short range of GCP health-checkers IPs"
  default     = []
}


variable "database_flags" {
  description = "The database flags for the master instance. See [more details](https://cloud.google.com/sql/docs/postgres/flags)"
  type = list(object({
    name  = string
    value = string
  }))
  default = [{
  name  = "cloudsql.enable_pg_cron"
  value = "on"
  }]
}
