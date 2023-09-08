variable "vpc" {
    type = object({
        vpc_name = string
        cidr_block = string
    })
}