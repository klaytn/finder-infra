output "ovpn_internal_ip" {
    value = module.openvpn.ovpn_internal_ip
}

# output "gke_hd_dev_node_sa" {
#     value = google_service_account.gke_node_no_priv.email
# }