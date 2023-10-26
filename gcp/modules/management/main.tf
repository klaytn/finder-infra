resource "google_compute_instance" "zoonavigator" {
  project      = var.project
  name         = "zoonavigator"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["ssh", "http-server"]

  boot_disk {
    initialize_params {
      image = "gce-uefi-images/cos-stable"
    }
  }

  network_interface {
    subnetwork = var.subnetwork
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = "docker run -d -p 80:9000 -e HTTP_PORT=9000 --name zoonavigator --restart unless-stopped elkozmon/zoonavigator:latest"
  
}

resource "google_compute_instance" "kafka_manager" {
  project      = var.project
  name         = "kafka-manager"
  machine_type = "g1-small"
  zone         = var.zone
  tags         = ["ssh", "http-server"]

  boot_disk {
    initialize_params {
      image = "gce-uefi-images/cos-stable"
    }
  }

  network_interface {
    subnetwork = var.subnetwork
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = "docker run -d -p 80:9000 -e ZK_HOSTS='finder-zookeeper-prod-1:2181,finder-zookeeper-prod-1:2181,finder-zookeeper-prod-1:2181' -e APPLICATION_SECRET=password sheepkiller/kafka-manager"

}
