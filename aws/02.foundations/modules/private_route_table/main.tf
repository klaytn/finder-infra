resource "aws_route_table" "this" {
    count = length(var.subnets.name)
    vpc_id = var.vpc.vpc_id

    tags = {
        Name = "${var.subnets.name[count.index]}-route-table"
    }
}

resource "aws_route_table_association" "this" {
    count = length(var.subnets.name)
    route_table_id = aws_route_table.this[count.index].id
    subnet_id = var.subnets.id[count.index]
}

resource "aws_route" "this" {
    count = length(var.subnets.name)
    route_table_id         = aws_route_table.this[count.index].id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id         = var.netgateway_info.id[count.index]
}