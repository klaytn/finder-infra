variable "availability_zones" {
    type    = list(string)
}

variable "subnets" {
    type = object({
        name         = string
        newbits      = number
        netnum       = number
    })
}

variable "vpc" {
    type = object({
        vpc_id = string
        vpc_name = string
        cidr_block = string
    })
}