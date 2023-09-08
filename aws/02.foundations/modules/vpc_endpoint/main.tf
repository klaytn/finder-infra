resource "aws_vpc_endpoint" "this" {
    vpc_id       = var.vpc.vpc_id
    service_name = var.vpc_endpoint_service
    vpc_endpoint_type = "Gateway"
    tags = {
        Name = var.vpc_endpoint_name
        Environment = var.phase
    }
}

resource "aws_vpc_endpoint_route_table_association" "route_1" {
    count = length(var.route_1_table_id)
    route_table_id  = var.route_1_table_id[count.index]
    vpc_endpoint_id = aws_vpc_endpoint.this.id
}

resource "aws_vpc_endpoint_route_table_association" "route_2" {
    count = length(var.route_2_table_id)
    route_table_id  = var.route_2_table_id[count.index]
    vpc_endpoint_id = aws_vpc_endpoint.this.id
}