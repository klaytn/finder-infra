module "network-finder-prod-vpc" {
    source  = "terraform-google-modules/network/google"
    version = "~> 5.0"

    project_id   = var.project_id
    network_name = "vpc-${var.project_name}-prod"
    routing_mode = "GLOBAL"

    subnets = [
        {
        subnet_name           = "sb-${var.project_name}-prod-k8s-shared"
        subnet_ip             = "10.178.0.0/24"
        subnet_region         = "${var.region}"
        subnet_private_access = true
        subnet_flow_logs      = true
        },
        {
        subnet_name           = "sb-${var.project_name}-prod-shared"
        subnet_ip             = "10.178.1.0/24"
        subnet_region         = "${var.region}"
        subnet_private_access = true
        subnet_flow_logs      = true
        },
    ]
    secondary_ranges = {
        sb-finder-prod-k8s-shared= [
        {
            range_name    = "pod-${var.project_name}-prod-seconday-range"
            ip_cidr_range = "10.150.32.0/20"
        },
        {
            range_name    = "service-${var.project_name}-prod-seconday-range"
            ip_cidr_range = "10.151.2.0/24"
        }
        ]
    }
    depends_on = [
        module.enabled_google_apis,
    ]
}
