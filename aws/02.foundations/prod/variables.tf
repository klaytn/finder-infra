variable aws_region {
    description = "AWS region"
    type        = string
}

variable aws_profile_name {
    description = "AWS profile name"
    type        = string
}

variable "vpc" {
  type = object({
    vpc_name = string,
    cidr_block = string,
  })
}

variable "vpc_endpoint_service" {
  type = string
}

variable "vpc_endpoint_name" {
  type = string
}

variable "availability_zones" {
  type    = list(string)
  default = [] # Add your availability zones here
}

variable "public_subnet" {
  type = object({
    name         = string
    newbits      = number
    netnum       = number
  })
    default = {
      name    = "public",
      newbits = 8,
      netnum  = 10
    }
}

variable "private_db_subnet" {
  type = object({
    name         = string
    newbits      = number
    netnum       = number
  })
    default = {
      name    = "private_db",
      newbits = 8,
      netnum  = 30
    }
}

variable "private_eks_subnet" {
  type = object({
    name         = string
    newbits      = number
    netnum       = number
  })
    default = {
      name    = "private_eks",
      newbits = 4,
      netnum  = 4
    }
}

variable "private_en_subnet" {
  type = object({
    name         = string
    newbits      = number
    netnum       = number
  })
    default = {
      name    = "private_en",
      newbits = 8,
      netnum  = 40
    }
}

variable "private_1_subnet" {
  type = object({
    name         = string
    newbits      = number
    netnum       = number
  })
    default = {
      name    = "private_1",
      newbits = 8,
      netnum  = 20
    }
}

variable "private_2_subnet" {
  type = object({
    name         = string
    newbits      = number
    netnum       = number
  })
    default = {
      name    = "private_2",
      newbits = 8,
      netnum  = 50
    }
}

variable "phase" {
  type = string
}