resource "aws_elasticache_subnet_group" "this" {
    name       = "${replace(var.vpc.vpc_name,"_","-")}-elasticache-subnet-group"
    subnet_ids = var.subnets.id[*]
}

resource "aws_db_subnet_group" "this" {
  name       = "${replace(var.vpc.vpc_name,"_","-")}-db-subnet-group"
  subnet_ids = var.subnets.id[*]
}

resource "aws_docdb_subnet_group" "this" {
  name       = "${replace(var.vpc.vpc_name,"_","-")}-docdb-subnet-group"
  subnet_ids = var.subnets.id[*]
}