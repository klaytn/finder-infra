variable "project" {
    description = "The project ID to manage the service account."
    type        = string
    default     = ""
}

variable "account_id" {
    description = "The service account ID."
    type        = string
    default     = ""
}

variable "role" {
    description = "The role that should be applied to the members."
    type        = string
    default     = ""
}

variable "member" {
    description = "The members that should be granted the role."
    type        = string
    default     = ""
}