output "rds_role_name" {
    value = aws_iam_role.this.name
}

output "rds_role_arn" {
    value = aws_iam_role.this.arn
}
