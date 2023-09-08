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

resource "aws_eip" "nat" {
    count = length(var.subnets.name)
    vpc   = true
}

resource "aws_nat_gateway" "nat" {
    count = length(var.subnets.name)
    allocation_id = aws_eip.nat[count.index].id
    subnet_id = var.subnets.id[count.index]

    tags = {
        Name = "nat-gw-${format("%02d", count.index+1)}-${var.vpc.vpc_name}"
    }
}

resource "aws_route" "this" {
    count                  = length(var.subnets.name)
    route_table_id         = aws_route_table.this[count.index].id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id             = aws_internet_gateway.this.id
}

resource "aws_internet_gateway" "this" {
    vpc_id = var.vpc.vpc_id

    tags = {
        Name = "igw-${var.vpc.vpc_name}"
    }
}
