resource "aws_rds_cluster" "default" {
  cluster_identifier              = var.name
  engine                          = var.engine
  engine_version                  = var.engine_version
  availability_zones              = var.availability_zones
  database_name                   = var.database_name
  master_username                 = var.master_username
  master_password                 = var.master_password
  backup_retention_period         = var.backup_retention_period
  deletion_protection             = var.deletion_protection
  iam_roles                       = var.iam_roles
  vpc_security_group_ids          = [aws_security_group.default.id]
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.default.name
  db_subnet_group_name            = var.db_subnet_group_name
  skip_final_snapshot             = var.skip_final_snapshot
  preferred_backup_window         = "15:00-15:30"
  preferred_maintenance_window    = "sun:18:00-sun:18:30"
}

resource "aws_rds_cluster_instance" "default" {
  count                        = var.instance_count
  identifier                   = "${var.name}-${count.index}"
  cluster_identifier           = aws_rds_cluster.default.id
  instance_class               = var.instance_class
  engine                       = aws_rds_cluster.default.engine
  engine_version               = aws_rds_cluster.default.engine_version
  auto_minor_version_upgrade   = false
  preferred_maintenance_window = "sun:18:00-sun:18:30"
}

resource "aws_rds_cluster_parameter_group" "default" {
  name        = "${var.name}-pg"
  family      = var.pg_family
  description = "${var.name} db cluster parameter group"

  parameter {
    name  = "aws_default_s3_role"
    value = var.aws_default_s3_role
  }
}