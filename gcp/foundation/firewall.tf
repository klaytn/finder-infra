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
        description             = "Allow ingress for icmp"
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
        description             = "Allow ingress for udp"
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
            ports    = ["2181", "2888", "3888", "9092"]
        }]
        deny = []
        log_config = {
            metadata = "INCLUDE_ALL_METADATA"
        }
    },
    {
        name                    = "allow-dataproc"
        description             = "Allow ingress for TCP"
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
    }]
}
