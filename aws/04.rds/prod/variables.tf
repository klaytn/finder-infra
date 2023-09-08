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

variable "rds_role_name" {
    type = string
}

variable "rds_name" {
    type = string
}

variable "instance_class" {
    type = string
    default = "db.r5.large"
}

variable "database_name" {
    type = string
}

variable "cidr" {
    type = string
    default = "10.1.0.0/16"
}

variable "master_username" {
    type = string
}

variable "master_password" {
    type = string
}

variable "availability_zones" {
    type = list(string)
}

variable "port" {
    type = number
    default = 3306
}