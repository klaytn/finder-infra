output "vpc_info" {
    value = {
        vpc_id = module.vpc.vpc_info.vpc_id
        vpc_name = module.vpc.vpc_info.vpc_name
        cidr_block = module.vpc.vpc_info.cidr_block
    }
    description = "vpc info"
}

output "vpc_endpoint_info" {
    value = module.vpce.vpce_info
    description = "vpc endpoint info"
}

output "aws_elasticache_subnet_group" {
    value = {
        name = module.subnet_group.aws_elasticache_subnet_group.name
    }
    description = "elasticache subnet group info"
}

output "aws_db_subnet_group" {
    value = {
        name = module.subnet_group.aws_db_subnet_group.name
    }
    description = "database subnet group info"
}

output "aws_docdb_subnet_group" {
    value = {
        name = module.subnet_group.aws_docdb_subnet_group.name
    }
    description = "doc db subnet group info"
}

output "public_subnet_info" {
    value = {
        name = module.public_subnet.subnet_info.name
        id = module.public_subnet.subnet_info.id
    }
    description = "public subnet info"
}


output "private_db_subnet_info" {
    value = {
        name = module.private_db_subnet.subnet_info.name
        id = module.private_db_subnet.subnet_info.id
    }
    description = "private subnet info"
}

output "private_eks_subnet_info" {
    value = {
        name = module.private_eks_subnet.subnet_info.name
        id = module.private_eks_subnet.subnet_info.id
    }
    description = "private subnet info"
}

output "private_en_subnet_info" {
    value = {
        name = module.private_en_subnet.subnet_info.name
        id = module.private_en_subnet.subnet_info.id
    }
    description = "private subnet info"
}

output "private_1_route_table_info" {
    value = module.route_1_table.private_route_table_info
}

output "private_1_subnet_info" {
    value = {
        name = module.private_1_subnet.subnet_info.name
        id = module.private_1_subnet.subnet_info.id
    }
    description = "private 1 subnet info"
}

output "private_2_route_table_info" {
    value = module.route_2_table.private_route_table_info
}

output "private_2_subnet_info" {
    value = {
        name = module.private_2_subnet.subnet_info.name
        id = module.private_2_subnet.subnet_info.id
    }
    description = "private 2 subnet info"
}