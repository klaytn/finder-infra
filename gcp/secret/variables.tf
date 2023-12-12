variable "secret_name" {
    type = string
    description = "The name of the secret"
}

variable "secret_data" {
    type = string
    description = "The secret data"
}

// KMS
variable "kms_keyring" {
    description = "Keyring name."
    type        = string
}

variable "kms_keys" {
    description = "Key names."
    type        = list(string)
    default     = []
}

variable "bucket" {
    type = string
    description = "terraform bucket name"
}