module "vpc" {
    source = "../modules/vpc"
    vpc = {
        vpc_name = var.vpc.vpc_name
        cidr_block = var.vpc.cidr_block
    }
}

# subnets

module "public_subnet" {
    source = "../modules/public_subnet"
    availability_zones = var.availability_zones
    vpc = module.vpc.vpc_info
    subnets    = var.public_subnet
    depends_on = [ module.vpc ]
}

module "private_db_subnet" {
    source = "../modules/private_subnet"
    availability_zones = var.availability_zones
    vpc = module.vpc.vpc_info
    subnets    = var.private_db_subnet
}

module "private_eks_subnet" {
    source = "../modules/private_subnet"
    availability_zones = var.availability_zones
    vpc = module.vpc.vpc_info
    subnets    = var.private_eks_subnet
    depends_on = [ module.vpc ]
}

module "private_en_subnet" {
    source = "../modules/private_subnet"
    availability_zones = var.availability_zones
    vpc = module.vpc.vpc_info
    subnets    = var.private_en_subnet
    depends_on = [ module.vpc ]
}

module "private_1_subnet" {
    source = "../modules/private_subnet"
    availability_zones = var.availability_zones
    vpc = module.vpc.vpc_info
    subnets    = var.private_1_subnet
    depends_on = [ module.vpc ]
}

module "private_2_subnet" {
    source = "../modules/private_subnet"
    availability_zones = var.availability_zones
    vpc = module.vpc.vpc_info
    subnets    = var.private_2_subnet
    depends_on = [ module.vpc ]
}


# subnets group

module "subnet_group" {
    source = "../modules/subnet_group"
    vpc = module.vpc.vpc_info
    subnets    = module.private_db_subnet.subnet_info
    depends_on = [ module.vpc, module.private_db_subnet ]
}


# route tables

module "route_public_table" {
    source = "../modules/public_route_table"
    vpc = module.vpc.vpc_info
    subnets    = module.public_subnet.subnet_info
    depends_on = [ module.vpc, module.public_subnet ]
}

module "route_db_table" {
    source = "../modules/private_route_table"
    vpc = module.vpc.vpc_info
    subnets    = module.private_db_subnet.subnet_info
    depends_on = [ module.vpc, module.public_subnet, module.private_db_subnet ]
    netgateway_info = module.route_public_table.netgateway_info
}

module "route_eks_table" {
    source = "../modules/private_route_table"
    vpc = module.vpc.vpc_info
    subnets    = module.private_eks_subnet.subnet_info
    depends_on = [ module.vpc, module.private_eks_subnet, module.public_subnet ]
    netgateway_info = module.route_public_table.netgateway_info       
}

module "route_en_table" {
    source = "../modules/private_route_table"
    vpc = module.vpc.vpc_info
    subnets    = module.private_en_subnet.subnet_info
    depends_on = [ module.vpc, module.public_subnet, module.private_en_subnet ]
    netgateway_info = module.route_public_table.netgateway_info           
}

module "route_1_table" {
    source = "../modules/private_route_table"
    vpc = module.vpc.vpc_info
    subnets    = module.private_1_subnet.subnet_info
    depends_on = [ module.vpc, module.private_1_subnet, module.public_subnet]
    netgateway_info = module.route_public_table.netgateway_info               
}

module "route_2_table" {
    source = "../modules/private_route_table"
    vpc = module.vpc.vpc_info
    subnets    = module.private_2_subnet.subnet_info
    depends_on = [ module.vpc, module.private_2_subnet, module.public_subnet ]
    netgateway_info = module.route_public_table.netgateway_info               
}

module "vpce" {
    source = "../modules/vpc_endpoint"
    vpc = module.vpc.vpc_info
    phase = var.phase
    vpc_endpoint_service = var.vpc_endpoint_service
    vpc_endpoint_name = var.vpc_endpoint_name
    route_1_table_id = module.route_1_table.private_route_table_info.id[*]
    route_2_table_id = module.route_2_table.private_route_table_info.id[*]
    depends_on = [ module.vpc, module.private_1_subnet, module.route_1_table ]
}