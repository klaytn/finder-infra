output "private_route_table_info" {
    value = {
        id = aws_route_table.this[*].id
    }
    description = "private route table info"
}   