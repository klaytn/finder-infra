variable "aws_region" {
    description = "AWS region"
    type        = string
    default     = "default"
}

variable "aws_profile_name" {
    description = "AWS profile name"
    type        = string
}

variable "s3_burket_lake_id" {
    description = "S3 bucket name"
    type        = string
}

variable "s3_burket_spark_id" {
    description = "S3 bucket name"
    type        = string
}

variable "phase" {
    type = string
    default = "prod"
}