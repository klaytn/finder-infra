#!/bin/bash

sudo su -

# Initialize
mkdir -p /etc/systemd/system/elasticsearch.service.d
echo '' > /etc/elasticsearch/elasticsearch.yml
echo '' > /etc/security/limits.conf
echo '' > /etc/systemd/system/elasticsearch.service.d/override.conf

# Configure elasticsearch
HOSTNAME=$(hostname -s)
echo "node.name: $HOSTNAME" >> /etc/elasticsearch/elasticsearch.yml
cat <<'EOF' >>/etc/elasticsearch/elasticsearch.yml
action.destructive_requires_name: false
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
path.data: ${elasticsearch_data_dir}
path.logs: ${elasticsearch_logs_dir}
bootstrap.memory_lock: true

# turn off https
xpack.security.enabled: ${security_enabled}
xpack.security.transport.ssl.enabled: false
xpack.security.http.ssl.enabled: false
EOF

# Set the zone for shard allocation awareness.
ZONE=$(basename $(curl -sf -H "Metadata-Flavor: Google" http://metadata/computeMetadata/v1/instance/zone)) 
echo "node.attr.zone: $ZONE" >> /etc/elasticsearch/elasticsearch.yml

cat <<'EOF' >>/etc/security/limits.conf
# allow user 'elasticsearch' mlockall
elasticsearch soft memlock unlimited
elasticsearch hard memlock unlimited
EOF

cat <<'EOF' >>/etc/systemd/system/elasticsearch.service.d/override.conf
[Service]
LimitMEMLOCK=infinity
EOF

# Storage
mkdir -p ${elasticsearch_logs_dir}
chown -R elasticsearch:elasticsearch ${elasticsearch_logs_dir}

mkdir -p ${elasticsearch_data_dir}
chown -R elasticsearch:elasticsearch ${elasticsearch_data_dir}

# Configuring system settings
echo "elasticsearch  -  nofile  65535" >> /etc/security/limits.conf
echo "elasticsearch  -  nproc  4096" >> /etc/security/limits.conf
sysctl -w vm.max_map_count=262144

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