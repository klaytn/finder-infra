resource "google_compute_instance" "en_node" {
  project      = var.project
  name         = var.name
  machine_type = var.machine_type
  zone         = var.zone
  tags         = var.tags

  boot_disk {
    initialize_params {
      image         = "ubuntu-os-cloud/ubuntu-2004-lts"
      size          = var.disk_size_gb
    }
  }

  network_interface {
    subnetwork       = var.subnetwork
    access_config {}
  
   }

   metadata ={
     VmDnsSetting="GlobalOnly"
   }
}