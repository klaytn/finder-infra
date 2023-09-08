output "msk_cluster_id" {
  value = aws_msk_cluster.kafka_cluster.id
}

output "msk_sg_id" {
  value = aws_security_group.kafka-sg.id
}

output "zookeeper_connect_string" {
  value = aws_msk_cluster.kafka_cluster.zookeeper_connect_string
}

output "bootstrap_brokers_tls" {
  description = "TLS connection host:port pairs"
  value       = aws_msk_cluster.kafka_cluster.bootstrap_brokers_tls
}
