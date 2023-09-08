output "vpce_info" {
    value = {
        id = aws_vpc_endpoint.this.id
        vpc_id = aws_vpc_endpoint.this.vpc_id
        service_name = aws_vpc_endpoint.this.service_name
        state = aws_vpc_endpoint.this.state
        tags = aws_vpc_endpoint.this.tags
    }
}