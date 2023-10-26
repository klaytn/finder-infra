resource "google_compute_instance" "zookeeper" {
  project      = var.project
  count        = "${var.servers}"
  name         = "finder-zookeeper-prod-${count.index + 1}"
  machine_type = "n1-standard-2"
  zone         = var.zone
  tags         = ["ssh"]

  boot_disk {
    initialize_params {
      image = "packer-zoo"
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

  metadata_startup_script = "${element(data.template_file.zk_startup.*.rendered, count.index)}"

}