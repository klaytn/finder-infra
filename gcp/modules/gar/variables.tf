variable "project" {
  description = "The ID of the project in which the resources will be deployed."
  type        = string
}

variable "location" {
  description = "A variable that specifies the location where the Artifact Registry resource will be created."
  type        = string
  default     = "asia-northeast3"
}

variable "repository_id" {
  description = "A variable that defines the ID of the Artifact Registry repository."
  type        = string
}

variable "description" {
  description = "A variable that defines the description of the Artifact Registry repository."
  type        = string
}