variable "ami" {
  type = string
  default = ""
}

variable "name" {
  type = string
}

variable "phase" {
  type = string
}

variable "ec2_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "vpc_subnet_ids" {
  type = list(string)
}

variable "instance_type" {
  type = string
  description = "The instance type to use for the instance. Updates to this field will trigger a stop/start of the EC2 instance."
}

variable "root_volume_size_gib" {
  type = number
  description = "Size of the volume in gibibytes (GiB)"
}

# variable "ebs_volume_size_gib" {
#   type = number
#   description = "Size of the volume in gibibytes (GiB)"
# }
