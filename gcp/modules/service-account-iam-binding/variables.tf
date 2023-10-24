variable "service_name" {
    description = "The project ID to manage the service account."
    type        = string
    default     = ""
}

variable "role" {
    description = "The role that should be applied to the members."
    type        = string
    default     = ""
}

variable "members" {
    description = "The members that should be granted the role."
    type        = list(string)
    default     = []
}