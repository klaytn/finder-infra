resource "aws_msk_configuration" "kafka_broker_config" {
  kafka_versions = [var.kafka_version]
  name           = var.cluster_name

  server_properties = <<PROPERTIES
log.retention.ms=7776000000
message.max.bytes=52428800
PROPERTIES
}

resource "aws_msk_cluster" "kafka_cluster" {
  cluster_name           = var.cluster_name
  kafka_version          = var.kafka_version
  number_of_broker_nodes = var.broker_node_number

  broker_node_group_info {
    instance_type   = var.broker_instance_type
    ebs_volume_size = var.broker_ebs_volume_gb_size
    client_subnets = var.client_subnets
    security_groups = [aws_security_group.kafka-sg.id]
  }

  open_monitoring {
    prometheus {
      jmx_exporter {
        enabled_in_broker = true
      }
    }
  }

  encryption_info {
    encryption_in_transit {
      client_broker = "PLAINTEXT"
      in_cluster = false
    }
  }

  # 변경시 클러스터 무중단 rolling update.
  # 동일 arn 이고 수정이 발생할 경우 revision += 1
  configuration_info {
    arn      = aws_msk_configuration.kafka_broker_config.arn
    revision = 1
  }

  tags = {
    Name = var.cluster_name,
    Namespace = var.name_space,
    Stage = var.phase
  }
}
