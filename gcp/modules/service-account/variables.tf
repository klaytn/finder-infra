variable "account_id" {
    description = "The service account ID."
    type        = string
    default     = ""
}

variable "project" {
    description = "The project ID to manage the service account in."
    type        = string
    default     = ""
}

variable "display_name" {
    description = "The service account display name."
    type        = string
    default     = ""
}

variable "description" {
    description = "The service account description."
    type        = string
    default     = ""
}
