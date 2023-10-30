#!/bin/bash

exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Configure elasticsearch
cat <<'EOF' >>/etc/elasticsearch/elasticsearch.yml
cluster.name: ${cluster_name}

cloud:
  gce:
    project_id: ${project_id}
    zone: ${zones}
discovery:
  seed_providers: gce
  
network.host: "0.0.0.0"
network.publish_host: "_gce:hostname_"

# only data nodes should have ingest and http capabilities
node.roles: ${node_roles}
xpack.security.enabled: ${security_enabled}
path.data: ${elasticsearch_data_dir}
path.logs: ${elasticsearch_logs_dir}
bootstrap.memory_lock: true
EOF

# Set the zone for shard allocation awareness.
ZONE=$(basename $(curl -sf -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/zone)) 
echo "node.attr.zone: $ZONE" >> /etc/elasticsearch/elasticsearch.yml

cat <<'EOF' >>/etc/security/limits.conf

# allow user 'elasticsearch' mlockall
elasticsearch soft memlock unlimited
elasticsearch hard memlock unlimited
EOF

sudo mkdir -p /etc/systemd/system/elasticsearch.service.d
cat <<'EOF' >>/etc/systemd/system/elasticsearch.service.d/override.conf
[Service]
LimitMEMLOCK=infinity
EOF

# Setup heap size and memory locking
sudo sed -i 's/#MAX_LOCKED_MEMORY=.*$/MAX_LOCKED_MEMORY=unlimited/' /etc/init.d/elasticsearch
sudo sed -i 's/#MAX_LOCKED_MEMORY=.*$/MAX_LOCKED_MEMORY=unlimited/' /etc/default/elasticsearch

# Storage
sudo mkdir -p ${elasticsearch_logs_dir}
sudo chown -R elasticsearch:elasticsearch ${elasticsearch_logs_dir}

sudo mkdir -p ${elasticsearch_data_dir}
sudo chown -R elasticsearch:elasticsearch ${elasticsearch_data_dir}

# Configuring system settings
sudo sed -i '/^#session\s\+required\s\+pam_limits.so/s/^#//' /etc/pam.d/su
sudo echo "elasticsearch  -  nofile  65535" >> /etc/security/limits.conf
sudo echo "elasticsearch  -  nproc  4096" >> /etc/security/limits.conf
sudo sysctl -w vm.max_map_count=262144

# Start Elasticsearch
systemctl daemon-reload
systemctl enable elasticsearch.service
systemctl start elasticsearch.service

sleep 60
if [ `systemctl is-failed elasticsearch.service` == 'failed' ];
then
    echo "Elasticsearch unit failed to start"
    exit 1
fi