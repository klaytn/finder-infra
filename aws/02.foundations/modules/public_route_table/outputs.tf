output "netgateway_info" {
    value = {
        id = aws_nat_gateway.nat[*].id
    }
}