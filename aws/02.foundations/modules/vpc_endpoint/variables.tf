variable "vpc_endpoint_service" {
    type = string
}

variable "vpc_endpoint_name" {
    type = string
}

variable "vpc" {
    type = object({
        vpc_id = string
        vpc_name = string
        cidr_block = string
    })
}

variable "route_1_table_id" {
    type = list(string)
}

variable "route_2_table_id" {
    type = list(string)
}

variable "phase" {
    type = string
}
