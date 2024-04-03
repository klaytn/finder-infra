resource "google_compute_disk" "kafka-data-disk" {
  project                   = var.project
  count                     = "${var.servers}"
  name                      = "kafka-data-disk-${count.index + 1}"
  type                      = "pd-ssd"
  size                      = "512"
  zone                      = var.zone
}

resource "google_compute_instance" "kafka-broker" {
  project      = var.project
  count        = "${var.servers}"
  name         = "finder-kafka-prod-${count.index + 1}"
  machine_type = "n1-standard-2"
  zone         = var.zone
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "packer-kafka"
    }
  }

  network_interface {
    subnetwork = var.subnetwork
        access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    VmDnsSetting = "GlobalOnly"
  }

  metadata_startup_script = "${element(data.template_file.kafka_startup.*.rendered, count.index)}"
  
  lifecycle {
    ignore_changes = [attached_disk]
  }

  depends_on = [var.zookeeper_up]
  
}

resource "google_compute_attached_disk" "default" {
  project  = var.project
  zone     = var.zone
  count    = "${var.servers}"
  disk     = "${element(google_compute_disk.kafka-data-disk.*.self_link, count.index)}"
  instance = "${element(google_compute_instance.kafka-broker.*.self_link, count.index)}"
}
