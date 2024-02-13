module "gke" {
  source                     = "terraform-google-modules/kubernetes-engine/google//modules/beta-private-cluster-update-variant"
  project_id                 = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
  network_project_id         = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
  name                       = var.cluster_name
  region                     = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_regions[0]
  zones                      = ["${data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_regions[0]}-a"] 
  network                    = data.terraform_remote_state.foundation.outputs.vpc_finder_name.network_name
  subnetwork                 = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_names[0]
  ip_range_pods              = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_secondary_ranges[0][0].range_name
  ip_range_services          = data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_secondary_ranges[0][1].range_name
  http_load_balancing        = true
  network_policy             = false
  horizontal_pod_autoscaling = false
  filestore_csi_driver       = true
  enable_private_endpoint    = true
  enable_private_nodes       = true

  remove_default_node_pool   = true  
  initial_node_count         = 1

  // We enable Workload Identity by default.
  identity_namespace = "${data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id}.svc.id.goog"

  master_ipv4_cidr_block     = "172.10.1.0/28"
  master_authorized_networks = [{
    cidr_block   = "${data.terraform_remote_state.access.outputs.ovpn_internal_ip}/32"
    display_name = "ovpn host"
  }]  
  istio                      = true
  cloudrun                   = false
  dns_cache                  = false
  logging_service            = "logging.googleapis.com/kubernetes"

  node_pools = [
    {
      name                      = "finder-node-pool"
      machine_type              = "n1-standard-4"
      node_locations            = "${data.terraform_remote_state.foundation.outputs.vpc_finder_prod_subnets_regions[0]}-a"
      min_count                 = 1
      max_count                 = 10
      local_ssd_count           = 0
      spot                      = false
      local_ssd_ephemeral_count = 0
      disk_size_gb              = 50
      disk_type                 = "pd-standard"
      image_type                = "COS_CONTAINERD"
      enable_gcfs               = false
      enable_gvnic              = false
      auto_repair               = true
      auto_upgrade              = true
      service_account           = data.terraform_remote_state.sa.outputs.gke_node_service_account_email
      preemptible               = false
      initial_node_count        = 1
    },
  ]

  node_pools_oauth_scopes = {
    all = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  node_pools_labels = {
    all = {}

    default-node-pool = {
      default-node-pool = true
    }
  }

  node_pools_metadata = {
    all = {}

    finder-node-pool = {
      shutdown-script                 = "kubectl --kubeconfig=/var/lib/kubelet/kubeconfig drain --force=true --ignore-daemonsets=true --delete-local-data \"$HOSTNAME\""
      node-pool-metadata-custom-value = "finder-node-pool"
    }

  }

  node_pools_taints = {
    all = []

    finder-node-pool = [
      {
        key    = "finder-node-pool"
        value  = true
        effect = "PREFER_NO_SCHEDULE"
      },
    ]
      
  }

  node_pools_tags = {
    all = []

    finder-node-pool = [
      "finder-node-pool",
    ]

  }

  /* database_encryption = [
    {
      "key_name" : data.terraform_remote_state.secret.outputs.keys.gke-etcd-keys-prod-00
      "state" : "ENCRYPTED"
    }
  ] */
}

module "gke_auth" {
  source               = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  version              = "24.1.0"
  project_id           = data.terraform_remote_state.foundation.outputs.vpc_finder_name.project_id
  location             = module.gke.location
  cluster_name         = module.gke.name
  use_private_endpoint = true
  depends_on           = [module.gke]
}

resource "local_file" "kubeconfig" {
  content = module.gke_auth.kubeconfig_raw
  filename = "kubeconfig-finder-prod"
}