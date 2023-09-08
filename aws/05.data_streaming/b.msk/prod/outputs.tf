output "msk_info" {
    value = {
        msk_cluster_id = module.msk.msk_cluster_id,
        msk_sg_id = module.msk.msk_sg_id,
        zookeeper_connect_string = module.msk.zookeeper_connect_string,
        bootstrap_brokers_tls = module.msk.bootstrap_brokers_tls
    }
}