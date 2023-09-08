variable "vpc" {
    type = object({
        vpc_id = string
        vpc_name = string
        cidr_block = string
    })
}

variable "subnets" {
    type = object({
      id = list(string)
      name = list(string)
    })
}
