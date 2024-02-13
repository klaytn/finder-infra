module "firewall_rules_prod" {
    source       = "terraform-google-modules/network/google//modules/firewall-rules"
    project_id   = var.project_id
    network_name = module.network-finder-prod-vpc.network_name

    rules = [{
        name                    = "allow-ssh"
        description             = "Allow Ingress for SSH"
        direction               = "INGRESS"
        priority                = 1000
        ranges                  = ["10.178.0.0/24", "10.178.1.0/24", "10.178.2.0/24"]
        source_tags             = null
        source_service_accounts = null
        target_tags             = null
        target_service_accounts = null
        allow = [{
        protocol = "tcp"
        ports    = ["22"]
        }]
    deny = []
    log_config = {
        metadata = "INCLUDE_ALL_METADATA"
    }
    },
    {
        name                    = "allow-icmp"
        description             = "Allow ingress for ICMP"
        direction               = "INGRESS"
        priority                = 1000
        ranges                  = ["10.178.0.0/24", "10.178.1.0/24", "10.178.2.0/24"]
        source_tags             = null
        source_service_accounts = null
        target_tags             = null
        target_service_accounts = null
        allow = [{
            protocol = "icmp"
        }]
        deny = []
        log_config = {
            metadata = "INCLUDE_ALL_METADATA"
        }
    },
    {
        name                    = "allow-udp"
        description             = "Allow ingress for UDP"
        direction               = "INGRESS"
        priority                = 1000
        ranges                  = ["10.178.0.0/24", "10.178.1.0/24", "10.178.2.0/24"]
        source_tags             = null
        source_service_accounts = null
        target_tags             = null
        target_service_accounts = null
        allow = [{
            protocol = "udp"
            ports    = ["1194"]
        }]
        deny = []
        log_config = {
            metadata = "INCLUDE_ALL_METADATA"
        }
    },
    {
        name                    = "allow-tcp"
        description             = "Allow ingress for TCP"
        direction               = "INGRESS"
        priority                = 1000
        ranges                  = ["10.178.0.0/24", "10.178.1.0/24", "10.178.2.0/24"]
        source_tags             = null
        source_service_accounts = null
        target_tags             = null
        target_service_accounts = null
        allow = [{
            protocol = "tcp"
            ports    = ["80", "443"]
        }]
        deny = []
        log_config = {
            metadata = "INCLUDE_ALL_METADATA"
        }
    },
    {
        name                    = "allow-kafka"
        description             = "Allow ingress for kafka"
        direction               = "INGRESS"
        priority                = 1000
        ranges                  = ["10.178.0.0/24", "10.178.1.0/24", "10.178.2.0/24"]
        source_tags             = null
        source_service_accounts = null
        target_tags             = null
        target_service_accounts = null
        allow = [{
            protocol = "tcp"
            ports    = ["2181", "2888", "3888", "9092"]
        }]
        deny = []
        log_config = {
            metadata = "INCLUDE_ALL_METADATA"
        }
    },
    {
        name                    = "allow-dataproc"
        description             = "Allow ingress for dataproc"
        direction               = "INGRESS"
        priority                = 1000
        ranges                  = ["10.178.0.0/24", "10.178.1.0/24", "10.178.2.0/24"]
        source_tags             = null
        source_service_accounts = null
        target_tags             = ["finder-streaming-prod"]
        target_service_accounts = null
        allow = [{
            protocol = "all"
        }]
        deny = []
        log_config = {
            metadata = "INCLUDE_ALL_METADATA"
        }
    },
    {
        name                    = "allow-elasticsearch"
        description             = "Allow ingress for elasticsearch"
        direction               = "INGRESS"
        priority                = 1000
        ranges                  = ["10.178.0.0/24", "10.178.1.0/24", "10.178.2.0/24", "10.150.0.0/16"]
        source_tags             = null
        source_service_accounts = null
        target_tags             = ["finder-elasticsearch-prod"]
        target_service_accounts = null
        allow = [{
            protocol = "tcp"
            # 9200~9299: for REST API of elasticsearch
            # 9300~9305: for discover each node
            # 9300~9399: for communicate each node
            ports    = ["9200-9400"]
        }]
        deny = []
        log_config = {
            metadata = "INCLUDE_ALL_METADATA"
        }
    },
     {
        name                    = "allow-ennode-rpc"
        description             = "Allow port for en-node"
        direction               = "INGRESS"
        priority                = 1000
        ranges                  = ["10.178.0.0/24", "10.178.1.0/24", "10.178.2.0/24"]
        source_tags             = null
        source_service_accounts = null
        target_tags             = ["finder-en-node"]
        target_service_accounts = null
        allow = [{
            protocol = "tcp"
            ports    = ["8551"]
        }]
        deny = []
        log_config = {
            metadata = "INCLUDE_ALL_METADATA"
        }
    },
    ]
}
