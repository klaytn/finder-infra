variable "bucket" {
    type = stirng
    description = "terraform bucket name"
}

variable "ovpn_name" {
    type = string
    description = "open vpn name"
    default = "hd-dev-ovpn"  
}

variable "ovpn_subnet_number" {
    type = number
    description = "open vpn subnet number in vpc"
    default = 0
}

variable "users" {
    type = list(string)
    description = "users"
    default = ["developer"]
}