output "vpc_info" {
    value = {
        vpc_id = aws_vpc.this.id
        vpc_name = var.vpc.vpc_name
        cidr_block = var.vpc.cidr_block
    }
    description = "vpc info"
}