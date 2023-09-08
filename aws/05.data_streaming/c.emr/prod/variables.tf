variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "default"
}

variable "aws_profile_name" {
    description = "AWS profile name"
    type        = string
}

variable "s3_bucket" {
    description = "S3 bucket name"
    type        = string
}

variable "s3_foundation_key" {
    description = "s3 bucket key for foundation state file"
    type        = string
}

variable "s3_s3_key"{
    description = "s3 bucket key for s3 state file"
    type        = string
}

variable "phase" {
    type = string
}

variable "emr_name" {
    type = string
}

