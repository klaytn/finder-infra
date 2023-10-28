module "es" {
  source = "../../modules/elasticsearch"
  project = var.project
  name = var.name
  region = var.region
  zones = ["${var.region}-a"]
  # zones = ["${var.region}-a", "${var.region}-b"]
  machine_type = var.machine_type
  heap_size = var.heap_size
  master_node = true
  data_node = true
  ingestion_node = true
  disk_size_gb = var.disk_size_gb
}