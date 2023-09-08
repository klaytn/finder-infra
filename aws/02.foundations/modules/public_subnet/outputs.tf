output "subnet_info" {
    value = {
        name = aws_subnet.private[*].tags.Name
        id = aws_subnet.private[*].id
    }
}