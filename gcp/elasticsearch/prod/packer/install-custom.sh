#!/bin/bash

###
# Install cloud-plugin
###
set -e
cd /usr/share/elasticsearch

if (sudo dmidecode -s system-product-name | grep -q "Google Compute Engine"); then
  # install Google Compute specific plugins only if running on GCP
  sudo bin/elasticsearch-plugin install --batch discovery-gce
  sudo bin/elasticsearch-plugin install --batch repository-gcs
fi