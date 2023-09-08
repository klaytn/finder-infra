output "aws_elasticache_subnet_group" {
    value = {
        name = aws_elasticache_subnet_group.this.name
    }
    description = "elasticache subnet group info"
}

output "aws_db_subnet_group" {
    value = {
        name = aws_db_subnet_group.this.name
    }
    description = "database subnet group info"
}

output "aws_docdb_subnet_group" {
    value = {
        name = aws_docdb_subnet_group.this.name
    }
    description = "doc db subnet group info"
}